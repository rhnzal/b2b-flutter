// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:projectb2b/screen/favoritescreen.dart';
import 'package:projectb2b/screen/historyscreen.dart';
import 'package:projectb2b/screen/homescreen.dart';
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
    FavoriteScreen(),
    ProfileScreen()
  ];
  int currentIndex = 0;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  icon: Icon(Icons.home_rounded),
                  label: 'Home',
                  activeIcon: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 224, 232, 235),
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.home_rounded,
                        color: Color.fromARGB(255, 26, 25, 32),
                      ),
                    ),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history_rounded),
                  label: 'History',
                  activeIcon: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 224, 232, 235),
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.history_rounded,
                        color: Color.fromARGB(255, 26, 25, 32),
                      ),
                    ),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_rounded),
                  label: 'Wishlist',
                  activeIcon: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 224, 232, 235),
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.favorite_rounded,
                        color: Color.fromARGB(255, 26, 25, 32),
                      ),
                    ),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: 'Profile',
                  activeIcon: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 224, 232, 235),
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.person_rounded,
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