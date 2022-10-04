// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:projectb2b/screen/quotascreen.dart';
import 'package:projectb2b/screen/historyscreen.dart';
import 'package:projectb2b/screen/homescreen.dart';
import 'package:projectb2b/screen/paymentscreen.dart';
import 'package:projectb2b/screen/profilescreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final screen = [
    HomeScreen(),
    HistoryScreen(),
    QuotaScreen(),
    ProfileScreen()
  ];
  int currentIndex = 0;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 224, 232, 235),
      body: screen[currentIndex], 
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 30,
            selectedItemColor: Color.fromARGB(255, 26, 25, 32),
            unselectedItemColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 23, 22, 29),
            onTap: (index) => setState(() => currentIndex = index),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                  activeIcon: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 224, 232, 235),
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.home,
                        color: Color.fromARGB(255, 26, 25, 32),
                      ),
                    ),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history_outlined),
                  label: 'History',
                  activeIcon: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 224, 232, 235),
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.history,
                        color: Color.fromARGB(255, 26, 25, 32),
                      ),
                    ),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.payments_outlined),
                  label: 'Payment',
                  activeIcon: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 224, 232, 235),
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.payments_outlined,
                        color: Color.fromARGB(255, 26, 25, 32),
                      ),
                    ),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Profile',
                  activeIcon: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 224, 232, 235),
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 26, 25, 32),
                      ),
                    ),
                  )),
            ]),
      ),
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