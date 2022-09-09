// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projectb2b/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ElevatedButton(onPressed: () {  
          prefs.remove('token');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return Login();
          }));
        }, 
        child: Text("tes"),

        ),
      ),
    );
  }
}