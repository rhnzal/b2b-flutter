import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectb2b/endpoints.dart';
import 'package:projectb2b/screen/paymentscreen.dart';
import 'package:projectb2b/style.dart';
import 'package:projectb2b/widget/alertdialog.dart';
import 'package:projectb2b/widget/loadingoverlay.dart';
import 'package:projectb2b/widget/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projectb2b/http.dart' as http_test;
import 'package:projectb2b/widget/indicator.dart';
import 'package:projectb2b/widget/listdoc.dart';

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
  String? displayName;
  String? pfp;
  // String? username = '';

  @override
  void initState() {
    super.initState();
    initpreference();
  }

  Future<void> initpreference() async {
    prefs = await SharedPreferences.getInstance();
    displayName = prefs.getString('name');
    pfp = prefs.getString('pfp');
    getActivity();
    setState(() {});
  }


  Future<void> getActivity () async {
    var response = await http_test.get(url: urlDocument);

    if (response.isSuccess) {
      activity = response.data;
    } else {
      var error = response.message;
      if (mounted) {
        showDialog(
          context: context, 
          builder: (context) => MengDialog(
            title: 'Error', 
            content: error ?? 'Something was wrong', 
            buttons: const []
          )
        );
      }
    }

    if (mounted) {
      setState(() {
        isLoad = false;
      });
    }
  }

  Future<void> refreshList() async {
    setState(() {
      isLoad = true;
      getActivity();
    });
  }

  trimUrl (String trim) {
    if (trim.contains('https://')) {
      if (trim.contains('www.tradewheel.com')) {
        return trim.toString().substring(27);
      } else {
        return trim.toString().substring(8);
      }
    }else if (trim.contains('http://')) {
      return trim.toString().substring(7);
    }
  }

  confirm() async {
    //post the url while showing loading overlay
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) {
        return const LoadingOverlay();
      }
    );          
    var response = await http_test.post(
      url: urlInput, 
      body: {"url": url}
    );

    // if posting the url success loading overlay will pop and refresh the list
    if (response.isSuccess) {
      if (mounted) {
        Navigator.pop(context);
      }

      await getActivity();
      urlCon.clear();
      isActive = false;

    } else {
      var error = response.message;
      if (mounted) {
        Navigator.pop(context);
        urlCon.clear;

        showDialog(
          context: context, 
          builder: (context) {
            return MengDialog(
              title: 'Error', 
              content: error ?? 'Something went wrong', 
              buttons: error!.contains('quota') 
                ? [
                  MengDialogButton(
                    text: 'BUY', 
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.push(
                        context, 
                        CupertinoPageRoute(
                          builder: (context) {
                            return const PaymentScreen();
                          }
                        )
                      );
                    }
                  )
                ]
                : []
            );
          }
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                fontSize: 14
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintText: 'Input URL',
                hintStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(100, 0, 0, 0),
                  fontSize: 12
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20)
                )
              ),
              onChanged: (value) {
                url = value;
                setState(() {
                  isActive = value.contains('http://www.tradewheel.com') || value.contains('https://www.tradewheel.com') || value.contains('http://www.go4worldbusiness.com') || value.contains('https://www.go4worldbusiness.com') ? true : false;
                });
              },
            ),
          ),
          SizedBox(
            height: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                onSurface: const Color.fromARGB(255, 255, 255, 255),
                primary: const Color.fromARGB(255, 217, 217, 217),
                shape: const StadiumBorder(),
                elevation: 10
              ),
              onPressed: isActive ? () {
                showDialog(
                  context: context, 
                  builder: (context) {
                    return MengDialog(
                      title: 'Confirmation', 
                      content: 'Are you sure ?', 
                      buttons: [
                        MengDialogButton(
                          text: 'NO', 
                          onPressed: () {
                            Navigator.pop(context);
                          }
                        ),
                        MengDialogButton(
                          text: 'YES', 
                          onPressed: () {
                            Navigator.pop(context);
                            confirm();
                          }
                        )
                      ]
                    );
                  }
                );
              }: null,
              child: const Text(
                'Open',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 27, 26, 32),
                  fontSize: 12
                )
              )
            ),
          )
        ],
      ),
    );

    Widget recentActivity = Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        children: const [
          Icon(Icons.list_rounded),
          SizedBox(width: 5),
          Text(
            'Recent Activity',
            style: TextStyle(
              fontFamily: 'Inter', 
              fontWeight: FontWeight.w800, 
              fontSize: 14
            ),
          )
        ],
      ),
    );

    Widget listActivity = isLoad ? const Loading(pad: 100)
      : activity.isEmpty ? Expanded(
        child: RefreshIndicator(
          displacement: 10,
          backgroundColor: const Color.fromARGB(255, 224, 232, 235),
          color: const Color.fromARGB(255, 23, 22, 29),
          onRefresh: refreshList,
          child: ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              color: Colors.white,
              axisDirection: AxisDirection.down,
              child: ListView(
                children: const [Empty(pad: 100)]
              )
            )
          )
        )
      )
      : Expanded(
        child: RefreshIndicator(
          displacement: 10,
          backgroundColor: const Color.fromARGB(255, 224, 232, 235),
          color: const Color.fromARGB(255, 23, 22, 29),
          onRefresh: refreshList,
          child: ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: Colors.white,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemCount: (activity.length <= 3) ? activity.length : 3,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: ListDoc(
                    activity: activity,
                    index: index
                  )
                )
              ),
            ),
          ),
        ),
      );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 224, 232, 235),
        body: AnnotatedRegion(
          value: dark,
          child: Column(
            children: 
            [
              WelcomeUser(),
              inputURL,
              recentActivity, 
              listActivity
            ]
          ),
        ),
      ),
    );
  }
}