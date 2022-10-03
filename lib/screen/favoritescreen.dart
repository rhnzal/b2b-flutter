import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late SharedPreferences prefs;
  String? displayName = '';
  // var list = [];
  // bool isLoad = true;

  @override
  void initState(){
    super.initState();
    initpreference();
  }

  Future<void> initpreference() async {
    prefs = await SharedPreferences.getInstance();
    displayName = prefs.getString('name');
    // getActivity();
    setState(() {});
  }

  // Future<void> getActivity() async {
  //   var token = prefs.getString('token');
  //   final response = await http.get(
  //       Uri.parse("http://192.168.102.195:3000/api/document"),
  //       headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
  //   // print(response.body);
  //   list = json.decode(response.body)["data"];
  //   // print(activity);
  //   setState(() {
  //     isLoad = false;
  //   });
  // }

  // trimUrl(String trim){
  //   // for( var i = 0 ; i < activity.length; i++){
  //   //   var trim = activity[i]['url'];
  //   // }
  //   if (trim.contains('https://')){
  //   return trim.toString().substring(8);
  //   }else if(trim.contains('http://')){
  //   return trim.toString().substring(7);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Widget welcomeUser = Container(
    margin: const EdgeInsets.fromLTRB(20, 40, 10, 5),
    child: Row(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('images/user.png'),
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

  Widget wishlist = Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 10, 0),
      child: Row(
        children: const [
          Icon(Icons.list_rounded),
          SizedBox( width: 5,),
          Text('Wishlist',
            style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w800, fontSize: 12),
          )
        ],
      ),
    );

  Widget favoriteList =  Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.only(bottom: 20),
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
                    'Judul',
                    style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                      'Tanggal',
                    // DateFormat.yMMMd().format(DateTime.parse(activity[index]["createdAt"])),
                      style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 10)),
                  // Text(activity[index]["createdAt"])
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                    onSurface: const Color.fromARGB(255, 255, 255, 255),
                    primary: const Color.fromARGB(255, 217, 217, 217),
                    shape: const StadiumBorder(),
                    elevation: 10),
              onPressed: (){
                showDialog(
                  context: context, 
                  builder: ((context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    backgroundColor: Color.fromARGB(255, 224, 232, 235),
                    title: Text('Open this URL ?',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color.fromARGB(255, 26, 25, 32))),
                    content: Container(
                      height: 35,
                      child: Text('URL')
                      ),
                    actions: [
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                          minimumSize: MaterialStateProperty.all(Size.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 0, 10, 10))),
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        child: Text('Cancel',
                        style: TextStyle(
                                      color: Color.fromARGB(255, 23, 22, 29)))),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                          minimumSize: MaterialStateProperty.all(Size.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 0, 20, 10))),
                        onPressed: (){}, 
                        child: Text('Ok',
                        style: TextStyle(
                                      color: Color.fromARGB(255, 23, 22, 29))))
                    ],
                  )));
              }, 
              child: Text('Open', 
              style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 27, 26, 32),
                        fontSize: 12)))
          ],
        ),
      )
    )
  );

// Widget favoriteList = isLoad ? Container(
//           padding: const EdgeInsets.only(top: 150),
//           child:const CircularProgressIndicator(color: Color.fromARGB(255, 23, 22, 29),)) 
//         : list.isEmpty ? Container(
//           padding: const EdgeInsets.only(top: 150),
//           child: const Icon(Icons.folder_off_outlined, size: 60, color: Color.fromARGB(255, 26, 25, 32),),
//         )
//         : Expanded(
//             child: ScrollConfiguration(
//               behavior: const ScrollBehavior(),
//               child: GlowingOverscrollIndicator(
//                 axisDirection: AxisDirection.down,
//                 color: Colors.white,
//                 child: ListView.builder(
//                     itemCount: list.length,
//                     itemBuilder: (context, index) => Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                       child: Card(
//                         elevation: 10,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                         margin: const EdgeInsets.only(bottom: 20),
//                         child: Padding(
//                           padding:const EdgeInsets.fromLTRB(15, 20, 15, 20),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       // getUrl().toString(),
//                                       list[index]['judul'],
//                                       style: const TextStyle(
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 18),
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     Text(
//                                         // 'Tanggal',
//                                       DateFormat.yMMMd().format(DateTime.parse(list[index]["createdAt"])),
//                                         style: const TextStyle(
//                                             fontFamily: 'Inter',
//                                             fontWeight: FontWeight.w400,
//                                             fontSize: 10)),
//                                     // Text(activity[index]["createdAt"])
//                                   ],
//                                 ),
//                               ),
//                               ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                       onSurface: const Color.fromARGB(255, 255, 255, 255),
//                                       primary: const Color.fromARGB(255, 217, 217, 217),
//                                       shape: const StadiumBorder(),
//                                       elevation: 10),
//                                 onPressed: (){
//                                   showDialog(
//                                     context: context, 
//                                     builder: ((context) => AlertDialog(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.all(Radius.circular(20))
//                                       ),
//                                       backgroundColor: Color.fromARGB(255, 224, 232, 235),
//                                       title: Text('Open this URL ?',
//                                       style: TextStyle(
//                                         fontFamily: 'Inter',
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 20,
//                                         color: Color.fromARGB(255, 26, 25, 32))),
//                                       content: Container(
//                                         height: 35,
//                                         child: Text('URL')
//                                         ),
//                                       actions: [
//                                         TextButton(
//                                           style: ButtonStyle(
//                                             overlayColor: MaterialStateProperty.all(Colors.transparent),
//                                             minimumSize: MaterialStateProperty.all(Size.zero),
//                                             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                             padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 0, 10, 10))),
//                                           onPressed: (){
//                                             Navigator.pop(context);
//                                           }, 
//                                           child: Text('Cancel',
//                                           style: TextStyle(
//                                                         color: Color.fromARGB(255, 23, 22, 29)))),
//                                         TextButton(
//                                           style: ButtonStyle(
//                                             overlayColor: MaterialStateProperty.all(Colors.transparent),
//                                             minimumSize: MaterialStateProperty.all(Size.zero),
//                                             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                             padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 0, 20, 10))),
//                                           onPressed: (){}, 
//                                           child: Text('Ok',
//                                           style: TextStyle(
//                                                         color: Color.fromARGB(255, 23, 22, 29))))
//                                       ],
//                                     )));
//                                 }, 
//                                 child: Text('Open', 
//                                 style: TextStyle(
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w500,
//                                           color: Color.fromARGB(255, 27, 26, 32),
//                                           fontSize: 12)))
//                             ],
//                           ),
//                         )
//                       )
//                     )
//                       ),
//               ),
//             ),
//           );

  // Widget addItem = FloatingActionButton(
  //   onPressed: (){},
  //   );

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 232, 235),
      body: Column(
        children: [welcomeUser, wishlist,favoriteList],
      ),
    );
  }
}
