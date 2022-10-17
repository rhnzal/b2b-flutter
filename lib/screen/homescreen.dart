import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:projectb2b/endpoints.dart';
import 'package:projectb2b/screen/previewscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:projectb2b/http.dart' as http_test;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final formKey = GlobalKey<FormState>();
  // String trimmed = '';
  TextEditingController urlCon = TextEditingController();
  String url = '';
  late SharedPreferences prefs;
  bool isActive = false;
  bool isLoad = true;
  List activity = [];
  String? displayName = '';
  // String? username = '';
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
  //   final response = await http.get(Uri.parse(urlDocument),
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
    // print(response.body);
    print(response.status);
    if(response.isSuccess){
      activity = response.data;

    }else{
      showDialog(context: context, builder: ((context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(response.message.toString()),
        );
      }));
    }
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
      if(trim.contains('www.tradewheel.com')){
        return trim.toString().substring(27);
      }else{
        return trim.toString().substring(8);
      }
    }else if(trim.contains('http://')){
    return trim.toString().substring(7);
    }
  }

  confirm() async {
    showDialog(
    barrierDismissible: false,
        context: context, 
        builder: ((context) {
          return Center(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 224, 232, 235),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              padding: const EdgeInsets.all(20),
              child: const CircularProgressIndicator(
                color: Color.fromARGB(255, 23, 22, 29),
              )),
          );
      }));          
  var token = prefs.getString('token');
  // ignore: unused_local_variable
  var response = await http.post(Uri.parse(urlInput),
      headers: {
        HttpHeaders.contentTypeHeader:'application/json',
        HttpHeaders.authorizationHeader:'Bearer $token'
      },
      body: json.encode({
        'url': url,
      }));
  // print(response.body);
  Navigator.pop(context);
  await getActivity();
  urlCon.clear();
}

  @override
  Widget build(BuildContext context) {
    // var username = prefs.getString('username');
    Widget welcomeUser = Container(
      margin: const EdgeInsets.fromLTRB(20, 40, 10, 20),
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
                  // '$username',
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

    Widget inputURL = Container(
      height: 70,
      color: const Color.fromARGB(255, 23, 22, 29),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            height: 37,
            width: 240,
            child: TextFormField(
              controller: urlCon,
              cursorColor: Colors.black,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintText: 'Input URL',
                hintStyle: const TextStyle(
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
                setState(() {
                  isActive = value.contains('http://www.tradewheel.com') || value.contains('https://www.tradewheel.com') || value.contains('http://www.go4worldbusiness.com') || value.contains('https://www.go4worldbusiness.com') ? true : false;
                  // print(url);
                });
              }),
            ),
          ),
          SizedBox(
            height: 30,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    onSurface: const Color.fromARGB(255, 255, 255, 255),
                    primary: const Color.fromARGB(255, 217, 217, 217),
                    shape: const StadiumBorder(),
                    elevation: 10),
                onPressed: isActive ? () {
                        showDialog(
                            context: context,
                            builder: ((context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:const Color.fromARGB(255, 224, 232, 235),
                                  title: const Text('Confirmation'),
                                  titleTextStyle: const TextStyle(
                                      color: Color.fromARGB(255, 23, 22, 29),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600),
                                  content: const Text('Are You Sure ?'),
                                  contentTextStyle: const TextStyle(
                                      color: Color.fromARGB(255, 23, 22, 29)),
                                  actions: [
                                    TextButton(
                                        style: ButtonStyle(
                                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                                            minimumSize: MaterialStateProperty.all(Size.zero),
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 0, 10, 10))),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No',
                                            style: TextStyle(
                                                color: Color.fromARGB(255, 23, 22, 29)))),
                                    TextButton(
                                        style: ButtonStyle(
                                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                                            minimumSize: MaterialStateProperty.all(Size.zero),
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 0, 10, 10))),
                                        onPressed: () async {
                                    Navigator.pop(context);                               
                                    confirm();
                                        },
                                        child: const Text('Yes',
                                            style: TextStyle(color: Color.fromARGB(255, 23, 22, 29)
                                            )
                                          )
                                        )
                                  ],
                                )
                              )
                            );
                      }: null,
                child: const Text('Open',
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
      margin: const EdgeInsets.fromLTRB(20, 15, 10, 0),
      child: Row(
        children: const [
          Icon(Icons.list_rounded),
          SizedBox(width: 5),
          Text('Recent Activity',
            style: TextStyle(
                fontFamily: 'Inter', 
                fontWeight: FontWeight.w800, 
                fontSize: 12),
          )
        ],
      ),
    );

    Widget listActivity = isLoad ? Container(
          padding: const EdgeInsets.only(top: 100),
          child: const CircularProgressIndicator(color: Color.fromARGB(255, 23, 22, 29))
          )
        : activity.isEmpty ? Container(
          padding:const  EdgeInsets.only(top: 100),
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              // getUrl().toString(),
                                              trimUrl(activity[index]['url']).toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18),
                                              maxLines: 1,
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
                                ),
                              )
                            ),
                         )
                      ),
              ),
            ),
          );

    return Builder(
      builder: (context) {
         SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
        ));
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromARGB(255, 224, 232, 235),
          body: Column(
            children: [welcomeUser, inputURL, recentActivity, listActivity],
          ),
        );
      }
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