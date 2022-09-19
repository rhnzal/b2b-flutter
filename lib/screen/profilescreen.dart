// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projectb2b/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SharedPreferences prefs;
  String? displayName = '';
  var activity = [];
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    initpreference();
  }

  Future<void> initpreference() async {
    prefs = await SharedPreferences.getInstance();
    displayName = prefs.getString('name');
    getActivity();
    setState(() {});
  }

  Future<void> getActivity() async {
    var token = prefs.getString('token');
    final response = await http.get(
        Uri.parse("http://192.168.102.195:3000/api/document"),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    // print(response.body);
    activity = json.decode(response.body)["data"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget profilePreview = Container(
      margin: EdgeInsets.fromLTRB(40, 60, 40, 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('images/user.png'),
            radius: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$displayName',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 20)),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 30,
                  width: 109,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: ((context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor:
                                    Color.fromARGB(255, 23, 22, 29),
                                title: Text('Confirmation'),
                                titleTextStyle: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600),
                                content:
                                    Text('Are you sure want to Sign Out ?'),
                                contentTextStyle:
                                    TextStyle(color: Colors.white),
                                actions: [
                                  TextButton(
                                      style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size.zero),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.fromLTRB(
                                                  0, 0, 10, 10))),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('No',
                                          style:
                                              TextStyle(color: Colors.white))),
                                  TextButton(
                                      style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size.zero),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.fromLTRB(
                                                  0, 0, 10, 10))),
                                      onPressed: () {
                                        prefs.remove('token');
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return Login();
                                        }));
                                      },
                                      child: Text('Yes',
                                          style:
                                              TextStyle(color: Colors.white)))
                                ],
                              )));
                    },
                    child: Wrap(children: [
                      Icon(
                        Icons.logout_rounded,
                        color: Color.fromARGB(255, 26, 25, 32),
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Text("Sign Out",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color.fromARGB(255, 26, 25, 32)))
                    ]),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: StadiumBorder(),
                        elevation: 10),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );

    Widget editProfile = Container(
      height: 220,
      margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(255, 23, 22, 29),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            // name
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text("Display Name",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color.fromARGB(255, 224, 232, 235))),
                      SizedBox(height: 10),
                      Text(
                        "$displayName",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color.fromARGB(255, 224, 232, 235)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    width: 60,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: StadiumBorder(),
                            elevation: 10),
                        onPressed: () {},
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color.fromARGB(255, 26, 25, 32)),
                        )),
                  )
                ],
              ),
            ),
            // email
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text("Email",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color.fromARGB(255, 224, 232, 235))),
                      SizedBox(height: 10),
                      Text(
                        "something@mail.com",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color.fromARGB(255, 224, 232, 235)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    width: 60,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: StadiumBorder(),
                            elevation: 10),
                        onPressed: () {},
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color.fromARGB(255, 26, 25, 32)),
                        )),
                  )
                ],
              ),
            ),
            // password
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text("Password",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color.fromARGB(255, 224, 232, 235))),
                      SizedBox(height: 10),
                      Text(
                        "",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color.fromARGB(255, 224, 232, 235)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    width: 60,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: StadiumBorder(),
                            elevation: 10),
                        onPressed: () {},
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color.fromARGB(255, 26, 25, 32)),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );

    Widget quota = Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(255, 23, 22, 29),
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 232, 235),
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [profilePreview, editProfile, quota],
            ),
          ),
        ),
      ),
    );
  }
}
