import 'package:flutter/material.dart';
import 'package:projectb2b/endpoints.dart';
import 'package:projectb2b/style.dart';
import 'package:projectb2b/widget/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projectb2b/http.dart' as http_test;
import 'package:projectb2b/widget/listdoc.dart';
import 'package:projectb2b/widget/indicator.dart';

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
  String? pfp;
  String? displayName = '';
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

  Future<void> getActivity() async {
    var response = await http_test.get(url: urlDocument);
    if (response.isSuccess) {
      activity = response.data;

    } else {
      if (mounted) {
        showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(10)
              ),
              backgroundColor: const Color.fromARGB(255, 224, 232, 235),
              title: const Text('Error'),
              content: Text(response.message.toString())
            );
          }
        );
      }
    }
    // print(response.body);
    // print(activity);
    if (mounted) {
      setState(() {
        isLoad = false;
      });
    }
  }

  trimUrl(String trim) {
    // for( var i = 0 ; i < activity.length; i++){
    //   var trim = activity[i]['url'];
    // }
    if (trim.contains('https://')) {
      return trim.toString().substring(8);
    } else if (trim.contains('http://')) {
      return trim.toString().substring(7);
    }
  }

  Future<void> refreshList() async {
    setState(() {
      isLoad = true;
      getActivity();
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget history = Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 10, 10),
      child: Row(
        children: const [
          Icon(Icons.list_rounded),
          SizedBox( width: 5),
          Text(
            'History',
            style: TextStyle(
              fontFamily: 'Inter', 
              fontWeight: FontWeight.w800, 
              fontSize: 14
            ),
          )
        ],
      ),
    );
    
    Widget listHistory = isLoad ? const Loading()
      : activity.isEmpty ? const Empty()
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
                  physics: const BouncingScrollPhysics(),
                  itemCount: activity.length,
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
            children: [
              WelcomeUser(),
              history,
              listHistory
            ]
          ),
        ),
      ),
    );
  }
}
