import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectb2b/endpoints.dart';
import 'package:projectb2b/widget/alertdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projectb2b/http.dart' as http_test;
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isLoad = true;
  int selectedIndex = -1;
  bool selected = false;
  String? pfp;
  late SharedPreferences prefs;
  String? displayName = '';
  var grid = [];
  String url = '';
  bool urlLoad = true;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    initpreference();
  }

  Future<void> initpreference() async {
    prefs = await SharedPreferences.getInstance();
    displayName = prefs.getString('name');
    pfp = prefs.getString('pfp');
    getProduct();
    setState(() {});
  }

  Future<void> getProduct() async {
    var response = await http_test.get(url: urlProduct);
    // print(response.body);
    if (response.isSuccess) {
      grid = response.data;
      setState(() {
        isLoad = false;
      });
    } else {
      var error = response.message;
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            backgroundColor:const Color.fromARGB(255, 224, 232, 235),
            title: const Text('Error'),
            titleTextStyle: const TextStyle(
              color: Color.fromARGB(255, 23, 22, 29),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600
            ),
            content: Text('$error'),
            contentTextStyle: const TextStyle(color: Color.fromARGB(255, 23, 22, 29)),
            actions: [
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  minimumSize: MaterialStateProperty.all(Size.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(0, 0, 10, 10)
                  )
                ),
                onPressed: () {
                  Navigator.pop(context);
                  getProduct();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Color.fromARGB(255, 23, 22, 29)),
                )
              ),
            ],
          )
        );
      }
    }
  }

  void payment() async{
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) {
        return Center(
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 224, 232, 235),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            padding: const EdgeInsets.all(20),
            child: const CircularProgressIndicator(
              color: Color.fromARGB(255, 23, 22, 29)
            )
          ),
        );
      }
    );  

    var response = await http_test.post(
      url: urlBuyProduct, 
      body: grid[selectedIndex]
    );

    if (response.isSuccess) {
      if (mounted) {
        Navigator.pop(context); 
      }
      var count = 0;
      if (mounted) {
        Navigator.push(
          context, 
          CupertinoPageRoute(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    onPressed: (){
                      Navigator.popUntil(
                        context, 
                        (route) {
                          return count++ == 2;
                        }
                      );
                    },
                  ),
                  backgroundColor: const Color.fromARGB(255, 23, 22, 29),
                  automaticallyImplyLeading: false,
                ),
                body: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: response.data['paymentUrl'],
                ),
              );
            }
          )
        );

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
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget welcomeUser = Container(
      margin: const EdgeInsets.fromLTRB(20, 40, 10, 5),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
              pfp ?? 'https://img.icons8.com/ios/512/contacts.png'
            ),
            radius: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome,',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w300,
                    fontSize: 10
                  )
                ),
                Text(
                  '$displayName',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 12
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

    Widget title = Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 0, 20),
        child: const Text(
          'Choose Quota',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 20
          )
        ),
      )
    );

    Widget quotaList = Expanded(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: grid.length,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(5),
            child: Card(
              elevation: (selectedIndex == index) ? 0 : 5,
              shape: (selectedIndex == index) ?
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color:  Color.fromARGB(255, 23, 22, 29), width: 2)
                )
                : RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                onTap: (){
                  setState(() {
                    selectedIndex = index;
                    // print(grid[selectedIndex]['id']);
                    selected = true;
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        grid[index]['title'].toString(),
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 18
                        ),
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Open ${grid[index]['quota'].toString()} URL',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 10
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),

                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        NumberFormat.simpleCurrency(locale:'in', decimalDigits: 0).format(grid[index]['price']),
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 18
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      )
    );

    Widget paymentButton = Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 23, 22, 29), 
          shape: const StadiumBorder()
        ),
        onPressed: selected ? () async {
          showDialog(
            context: context, 
            builder: (context) => MengDialog(
              title: 'Confirmation', 
              content: 'Are You Sure ?', 
              buttons: [
                // Action No
                MengDialogButton(
                  text: 'NO', 
                  onPressed: (){
                    Navigator.pop(context);
                  }
                ),

                // Action Yes
                MengDialogButton(
                  text: 'YES', 
                  onPressed: (){
                    Navigator.pop(context);
                    payment();
                  }
                )
              ]
            )
          );

        } : null,
        child: const SizedBox(
          width: 100,
          child: Text(
            'Continue',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 224, 232, 235)
            ),
          )
        )
      ),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 232, 235),
      body: Column(
        children: [
          welcomeUser, 
          title, 
          // check payment button
          if (!isLoad) ...[
            quotaList, 
            paymentButton
            
          ] else Container(
            padding: const EdgeInsets.only(top: 100),
            child: const CircularProgressIndicator(color: Color.fromARGB(255, 23, 22, 29)),
          ) 
        ],
      ),
    );
  }
}
