// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectb2b/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences prefs ;
  var activity = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initpreference();

  }

  Future<void> initpreference() async {
    prefs = await SharedPreferences.getInstance();
    getActivity();
    setState(() {});
  }
  Future<void> getActivity() async{
    var token = prefs.getString('token');
    final response = await http.get(Uri.parse("http://192.168.102.195:3000/api/document"),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}
    );
    // print(response.body);
    activity = json.decode(response.body)["data"];
    print(activity);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    String url = '';
    Widget welcomeUser = Container(
      margin: EdgeInsets.fromLTRB(20, 40, 10, 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('images/user.png'),
            radius: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome,',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w300,
                        fontSize: 10)),
                Text(
                  'User',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                )
              ],
            ),
          )
        ],
      ),
    );

    Widget inputURL = Container(
      height: 70,
      color: Color.fromARGB(255, 23, 22, 29),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 20),
            height: 37,
            width: 240,
            child: TextFormField(
              cursorColor: Colors.black,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
              decoration: InputDecoration(
                // prefixIcon: Image.asset('icons/email.png',height: 4 ),
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintText: 'Input URL',
                hintStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(100, 0, 0, 0),
                    fontSize: 12),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20)),
                // prefixIcon: Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                //   child: Icon(Icons.),
                // )
              ),
              onChanged: ((value) {
                url = value;
              }),
            ),
          ),
          Container(
            height: 30,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 217, 217, 217),
                  shape: StadiumBorder(),
                  elevation: 10
                ),
                onPressed: () async {
                  var token = prefs.getString('token');
                  var response = await http.post(
                      Uri.parse('http://192.168.102.195:3000/api/document/url'),
                      headers: {
                        HttpHeaders.contentTypeHeader: 'application/json',
                        HttpHeaders.authorizationHeader: 'Bearer $token'
                      },
                      body: json.encode({
                        'url': url,
                      }));
                  print(response.body);
                },
                child: Text('Open',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 27, 26, 32),
                        fontSize: 12))),
          )
        ],
      ),
    );

    Widget recentActivity = Container(
      margin: EdgeInsets.fromLTRB(20, 15, 10, 0),
      child: Row(
        children: const [
          Icon(Icons.list_rounded),
          SizedBox(
            width: 5,
          ),
          Text(
            'Recent Activity',
            style: TextStyle(
                fontFamily: 'Inter', fontWeight: FontWeight.w800, fontSize: 12),
          )
        ],
      ),
    );

    Widget listActivity = Expanded(
      child: ListView.builder(
      itemCount: activity.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          margin: EdgeInsets.only(bottom: 20),
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity[index]["url"], style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 18),),
                Text(DateFormat.yMMMd().format(DateTime.parse(activity[index]["createdAt"])), style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 10)),
                // Text(activity[index]["createdAt"])
              ],
            ),
          )
        ),
      )),
    );
    

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 232, 235),
      body: Column(
        children: [welcomeUser, inputURL, recentActivity, listActivity],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        selectedItemColor: Color.fromARGB(255, 26, 25, 32),
        unselectedItemColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 23, 22, 29),
        items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded), 
          label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_rounded), 
          label: 'History'),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_rounded), 
          label: 'Wishlist'),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded), 
          label: 'Profile'),
      ]),
    );
  }
}
        // child: ElevatedButton(onPressed: () {  
        //   prefs.remove('token');
        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        //     return Login();
        //   }));
        // }, 
        // child: Text("tes"),

        // ),