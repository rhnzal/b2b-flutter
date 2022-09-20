import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late SharedPreferences prefs;
  String? displayName = '';
  List grid = [
    {'name': 'Diamond', 'desc': 'Open 500 URL', 'price': 'Rp 899.000'},
    {'name': 'Gold', 'desc': 'Open 200 URL', 'price': 'Rp 599.000'},
    {'name': 'Silver', 'desc': 'Open 100 URL', 'price': 'Rp 249.000'},
    {'name': 'Bronze', 'desc': 'Open 50 URL', 'price': 'Rp 115.000'}
  ];

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
    setState(() {});
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

    Widget quotaList = Expanded(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: grid.length,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            itemBuilder: ((context, index) {
              return Container(
                padding: const EdgeInsets.all(5),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          grid[index]['name'],
                          style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          grid[index]['desc'],
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
                          grid[index]['price'],
                          style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              );
            })));

    Widget paymentButton = Container(
      margin: const EdgeInsets.all(20),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 23, 22, 29), shape: StadiumBorder()),
          onPressed: () {},
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
        children: [welcomeUser, title, quotaList, paymentButton],
      ),
    );
  }
}
