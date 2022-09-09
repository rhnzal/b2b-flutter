import 'package:flutter/material.dart';
import 'package:projectb2b/home.dart';
import 'package:projectb2b/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');

  runApp(MyApp(token: token,));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.token}) : super(key: key);

  final String? token;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // void autoLogin() async{
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: widget.token != null ? Home() : Login(),
    );
  }
}
