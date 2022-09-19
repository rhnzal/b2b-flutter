import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late SharedPreferences prefs;
  String? displayName = '';

  @override
  void initState(){
    super.initState();
    initpreference();
  }

  Future<void> initpreference() async {
    prefs = await SharedPreferences.getInstance();
    displayName = prefs.getString('name');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget welcomeUser = Container(
    margin: const EdgeInsets.fromLTRB(20, 40, 10, 5),
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
                '$displayName',
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

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 232, 235),
      body: Column(
        children: [welcomeUser],
      ),
    );
  }
}
