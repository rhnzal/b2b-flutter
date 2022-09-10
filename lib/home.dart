// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projectb2b/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initpreference();
  }

  Future<void> initpreference() async {
    prefs = await SharedPreferences.getInstance();
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
            backgroundColor: Colors.amber,
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
      height: 80,
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
              style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 14),
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

    // Widget recentActivity = Container(

    // );

    // Widget navbar = BottomNavigationBar(items: items)

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 232, 235),
      body: Column(
        children: [welcomeUser, inputURL],
      ),
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