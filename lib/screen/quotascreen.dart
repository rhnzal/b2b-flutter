import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectb2b/endpoints.dart';
import 'package:projectb2b/screen/paymentscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projectb2b/http.dart' as http_test;

class QuotaScreen extends StatefulWidget {
  const QuotaScreen({Key? key}) : super(key: key);

  @override
  State<QuotaScreen> createState() => _QuotaScreenState();
}

class _QuotaScreenState extends State<QuotaScreen> {
  late SharedPreferences prefs;
  String? displayName = '';
  String quota = '';
  var list = [];
  bool isLoad = true;

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
    getQuota();
    getHistory();
  }

  getQuota()async{
    var response = await http_test.get(url: urlQuota);
    quota = response.data.toString();
    setState(() {});
  }

  getHistory()async{
    var response = await http_test.get(url: urlHistory);
    if(response.isSuccess){
      list = response.data;
      setState(() {
        isLoad = false;
      });
    }
  }

  // Future<void> getActivity() async {
  //   var token = prefs.getString('token');
  //   final response = await http.get(
  //       Uri.parse("https://sija-b2b.ronisetiawan.id/api/document"),
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
      margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
      child: Row(
        children: const [
          Icon(Icons.list_rounded),
          SizedBox( width: 5,),
          Text('Transaction History',
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
        child: Column(
          children: [
            Row(
              children: const [
                Text('Your Subscription : '),
                //nama paket
                Text('TEST',
                  style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                )
              ],
            ),
            const Divider(
              thickness: 2,
              color: Color.fromARGB(255, 224, 232, 235),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          'Remaining Quota :',
                        // DateFormat.yMMMd().format(DateTime.parse(activity[index]["createdAt"])),
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 10)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        // getUrl().toString(),
                        quota,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return const PaymentScreen();
                    },
                      settings: const RouteSettings(name: 'quota')
                    ));
                  }, 
                  child: const Text('Add', 
                  style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 27, 26, 32),
                            fontSize: 12)))
              ],
            ),
          ],
        ),
      )
    )
  );

// Widget transactionList = Padding(
//     padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//     child: Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15)),
//       margin: const EdgeInsets.only(bottom: 20),
//       child: Padding(
//         padding:const EdgeInsets.fromLTRB(15, 15, 15, 15),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     // getUrl().toString(),
//                     'Judul',
//                     style: TextStyle(
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w700,
//                         fontSize: 18),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Text(
//                       'Tanggal',
//                     // DateFormat.yMMMd().format(DateTime.parse(activity[index]["createdAt"])),
//                       style: TextStyle(
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.w400,
//                           fontSize: 10)),
//                   // Text(activity[index]["createdAt"])
//                 ],
//               ),
//             ),
//             const Text(
//                     // getUrl().toString(),
//                     'Status',
//                     style: TextStyle(
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w700,
//                         fontSize: 18),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   )
//           ],
//         ),
//       )
//     )
//   );

Widget transactionList= isLoad ? Container(
          padding: const EdgeInsets.only(top: 150),
          child:const CircularProgressIndicator(color: Color.fromARGB(255, 23, 22, 29),)) 
        : list.isEmpty ? Container(
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
                    itemCount: list.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
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
                                      list[index]['product']['title'],
                                      style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                        // 'Tanggal',
                                      DateFormat.yMMMd().format(DateTime.parse(list[index]["createdAt"])),
                                        style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10)),
                                    // Text(activity[index]["createdAt"])
                                  ],
                                ),
                              ),
                              Text(
                                      // getUrl().toString(),
                                      list[index]['product']['price'].toString(),
                                      style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ],
                          ),
                        )
                      )
                    )
                      ),
              ),
            ),
          );

  // Widget addItem = FloatingActionButton(
  //   onPressed: (){},
  //   );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 224, 232, 235),
      body: Column(
        children: [welcomeUser,favoriteList, wishlist, transactionList],
      ),
    );
  }
}
