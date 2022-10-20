import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectb2b/endpoints.dart';
import 'package:projectb2b/screen/previewscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:projectb2b/http.dart' as http_test;
import 'dart:convert';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late WebViewController controller;
  late SharedPreferences prefs;
  bool isLoad = true;
  var activity = [];
  String result = '';
  String? displayName = '';
  @override
  void initState() {
    super.initState();
    initpreference();
  }

  Future<void> initpreference() async {
    prefs = await SharedPreferences.getInstance();
    displayName = prefs.getString('name');
    getActivity();
    setState(() {});
  }

  // Future<void> getActivity() async {
  //   var token = prefs.getString('token');
  //   final response = await http.get(
  //       Uri.parse(urlDocument),
  //       headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
  //   // print(response.body);
  //   activity = json.decode(response.body)["data"];
  //   // print(activity);
  //   if(mounted){
  //     setState(() {
  //       isLoad = false;
  //     });
  //   }
  // }

  Future<void> getActivity() async {
    var response = await http_test.get(url: urlDocument);
    if(response.isSuccess){
      activity = response.data;
    }else{
      if(mounted){
      showDialog(context: context, builder: ((context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(10)),
          backgroundColor: const Color.fromARGB(255, 224, 232, 235),
          title: const Text('Error'),
          content: Text(response.message.toString()),
        );
      }));}
    }
    // print(response.body);
    // print(activity);
    if(mounted){
      setState(() {
        isLoad = false;
      });
    }
  }
  trimUrl(String trim){
    // for( var i = 0 ; i < activity.length; i++){
    //   var trim = activity[i]['url'];
    // }
    if (trim.contains('https://')){
    return trim.toString().substring(8);
    }else if(trim.contains('http://')){
    return trim.toString().substring(7);
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget welcomeUser = Container(
      margin: const EdgeInsets.fromLTRB(20, 40, 10, 5),
      child: Row(
        children: [
          // ignore: prefer_const_constructors
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: const AssetImage('images/user.png'),
            radius: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Welcome,',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w300,
                        fontSize: 10)),
                Text(
                  '$displayName',
                  style: const TextStyle(
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
      margin: const EdgeInsets.fromLTRB(20, 15, 10, 0),
      child: Row(
        children: const [
          Icon(Icons.list_rounded),
          SizedBox( width: 5,),
          Text('History',
            style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w800, fontSize: 12),
          )
        ],
      ),
    );

    Widget listHistory = isLoad ? Container(
          padding: const EdgeInsets.only(top: 150),
          child:const CircularProgressIndicator(color: Color.fromARGB(255, 23, 22, 29),)) 
        : activity.isEmpty ? Container(
          padding: const EdgeInsets.only(top: 150),
          child: const Icon(Icons.folder_off_outlined, size: 60, color: Color.fromARGB(255, 26, 25, 32),),
        )
        : Expanded(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Colors.white,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: activity.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              margin: const EdgeInsets.only(bottom: 20),
                              child: InkWell(
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                                onTap: (() {
                                  if (activity[index]['status'] == "SUCCESS") {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: ((context) {
                                      return PreviewScreen(
                                          url: activity[index]["result"]);
                                    }
                                  )
                                )
                              );
                                  } else {
                                    // loading
                                    showDialog(
                                        context: context,
                                        builder: ((context) => AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:BorderRadius.circular(10)),
                                              backgroundColor: const Color.fromARGB(255, 224, 232, 235),
                                              title: activity[index]['status'] =="LOADING" ? const Text('Your request is in queue')
                                                  : const Text('URL Invalid'),
                                              content: activity[index]['status'] == "LOADING" ? const Text('Please Wait')
                                                  : const Text('Try using another URL'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Ok',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(255, 23, 22, 29)),
                                                    ))
                                              ],
                                            )));
                                  }
                                }),
                                child: Padding(
                                  padding:const EdgeInsets.fromLTRB(15, 20, 15, 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  trimUrl(activity[index]["url"]),
                                                  style: const TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 18),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(DateFormat.yMMMd().format(DateTime.parse(activity[index]["createdAt"])),
                                                    style: const TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 10)),
                                                // Text(activity[index]["createdAt"])
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              const Text("Status",
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              const SizedBox(height: 5),
                                              // if(activity[index]['status'] == "SUCCESS"){
                                              //   Icon(Icons.done)
                                              // }
                                              if (activity[index]['status'] == "SUCCESS") ...[
                                                const Icon(Icons.done, color: Colors.green,)
                                              ] else if (activity[index]['status'] == "LOADING") ...[
                                                // const Icon(Icons.pending_outlined)
                                                const CupertinoActivityIndicator()
                                                // CircularProgressIndicator()
                                              ] else ...[
                                                const Icon(Icons.clear,color: Colors.red)
                                              ]
                                            ],
                                          )
                                        ],
                                      ),
                                      if (activity[index]['status'] == 'SUCCESS')...[
                                        if(activity[index]['url'].toString().contains('tradewheel') ||activity[index]['url'].toString().contains('go4worldbusiness') )...[
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 200,
                                            child: FadeInImage(
                                              image: NetworkImage(
                                                activity[index]['result'],
                                              ),
                                              placeholder: const AssetImage('./images/folder.png'),
                                            )
                                          )
                                        ]

                                    ]
                                    ],
                                  ),
                                ),
                              )
                            ),
                         )
                      ),
              ),
            ),
          );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 224, 232, 235),
      body: Column(children: [
        welcomeUser,
        history,
        listHistory
      ]),
    );
  }
}
