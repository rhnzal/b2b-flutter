import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isLoad = true;
  int selectedIndex = -1;
  bool selected = false;
  late SharedPreferences prefs;
  String? displayName = '';
  var grid = [];

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
    getProduct();
    setState(() {});
  }

  Future<void> getProduct() async{
    var token = prefs.getString('token');
    var response = await http.get(Uri.parse('http://192.168.102.195:3000/api/product'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token'
    }
    );
    print(response.body);
    grid = json.decode(response.body)['data'];
    setState(() {
      isLoad = false;
    });
  }

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

    Widget title = Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 20),
          child: const Text('Choose Quota',
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 20)),
        ));

    Widget quotaList = 
      Expanded(
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: grid.length,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            itemBuilder: ((context, index) {
              return Container(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      selectedIndex = index;
                      selected = true;
                    });
                  },
                  child: Card(
                    elevation: 5,
                    shape:(selectedIndex == index)? 
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color:  Color.fromARGB(255, 23, 22, 29), width: 2)
                        )
                      : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            grid[index]['title'].toString().substring(6),
                            style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'Open ${grid[index]['quota'].toString()} URL',
                            style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 10),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            NumberFormat.simpleCurrency(locale:'in').format(grid[index]['price']),
                            style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })));

    Widget paymentButton = Container(
      // alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 23, 22, 29), shape: const StadiumBorder()),
          onPressed: selected ? () async {
              var token = prefs.getString('token');
              var response = await http.post(Uri.parse('http://192.168.102.195:3000/api/transaction/buy'),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader: 'Bearer $token'
              },
              body: json.encode({
                'product' : grid[selectedIndex]['id']
              })
              );
              // print(response.body);
              // print(grid[selectedIndex]['id']);
          }:null,
          child: const SizedBox(
              width: 100,
              child: Text(
                'Continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 224, 232, 235)),
              ))),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 232, 235),
      body: Column(
        children: [
          welcomeUser, 
          title, 
          if (!isLoad) ...[quotaList, paymentButton] else Container(
          padding: const EdgeInsets.only(top: 100),
          child: const CircularProgressIndicator(color: Color.fromARGB(255, 23, 22, 29)),
          ) 
          ],
      ),
    );
  }
}
