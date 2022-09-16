import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:projectb2b/screen/previewscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late SharedPreferences prefs;
  bool isload = true;
  var activity = [];
  String result = '';
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

  Future<void> getActivity() async {
    var token = prefs.getString('token');
    final response = await http.get(
        Uri.parse("http://192.168.102.195:3000/api/document"),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    // print(response.body);
    activity = json.decode(response.body)["data"];
    print(activity);
    setState(() {
      isload = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget welcomeUser = Container(
      margin: EdgeInsets.fromLTRB(20, 40, 10, 5),
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

    Widget history = Container(
      margin: EdgeInsets.fromLTRB(20, 15, 10, 0),
      child: Row(
        children: const [
          Icon(Icons.list_rounded),
          SizedBox(
            width: 5,
          ),
          Text(
            'History',
            style: TextStyle(
                fontFamily: 'Inter', fontWeight: FontWeight.w800, fontSize: 12),
          )
        ],
      ),
    );

    Widget listHistory = Expanded(
      child: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.white,
          child: ListView.builder(
              itemCount: activity.length,
              itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(bottom: 20),
                      child: InkWell(
                          onTap: (() {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PreviewScreen(url: activity[index]['result']);
                            }));
                          }),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  activity[index]["url"],
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                Text(
                                    DateFormat.yMMMd().format(DateTime.parse(
                                        activity[index]["createdAt"])),
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10)),
                                // Text(activity[index]["createdAt"])
                              ],
                            ),
                          )),
                    ),
                  )),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 232, 235),
      body: Column(children: [
        welcomeUser,
        history,
        isload
            ? CircularProgressIndicator(
                color: Color.fromARGB(255, 23, 22, 29),
              )
            : listHistory
      ]),
    );
  }
}
