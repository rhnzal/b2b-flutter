import 'package:flutter/material.dart';
import 'package:projectb2b/home.dart';
import 'package:projectb2b/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.transparent
    )
  );
  runApp(MyApp(
    token: token,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.token}) : super(key: key);

  final String? token;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: widget.token != null ? const Home() : const Login(),
    );
  }
}
