import 'package:flutter/material.dart';
import 'package:projectb2b/home.dart';
import 'package:projectb2b/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  // void autoLogin() async{
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  // }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
    );
  }
}