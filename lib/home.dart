import 'package:flutter/material.dart';
import 'package:projectb2b/screen/quotascreen.dart';
import 'package:projectb2b/screen/historyscreen.dart';
import 'package:projectb2b/screen/homescreen.dart';
import 'package:projectb2b/screen/profilescreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final screen = const [
    HomeScreen(),
    HistoryScreen(),
    QuotaScreen(),
    ProfileScreen()
  ];
  int currentIndex = 0;

  PageController pageController = PageController(initialPage: 0);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 224, 232, 235),
      body: PageView(
        controller: pageController,
        onPageChanged: (index){
          setState(() {
            currentIndex = index;
          });
        },
        children: const[
          HomeScreen(),
          HistoryScreen(),
          QuotaScreen(),
          ProfileScreen()
        ],
      ), 
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
          selectedItemColor: const Color.fromARGB(255, 26, 25, 32),
          unselectedItemColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 23, 22, 29),
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: 'Home',
              activeIcon: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 224, 232, 235),
                    shape: BoxShape.circle),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 26, 25, 32),
                  ),
                ),
              )
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.history_outlined),
              label: 'History',
              activeIcon: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 224, 232, 235),
                    shape: BoxShape.circle),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.history,
                    color: Color.fromARGB(255, 26, 25, 32),
                  ),
                ),
              )
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.payments_outlined),
              label: 'Payment',
              activeIcon: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 224, 232, 235),
                    shape: BoxShape.circle),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.payments_outlined,
                    color: Color.fromARGB(255, 26, 25, 32),
                  ),
                ),
              )
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              label: 'Profile',
              activeIcon: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 224, 232, 235),
                    shape: BoxShape.circle),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 26, 25, 32),
                  ),
                ),
              )
            ),
          ]
        ),
      ),
    );
  }
}