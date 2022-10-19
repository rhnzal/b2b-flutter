import 'package:flutter/material.dart';
import 'package:projectb2b/screen/login.dart';
import 'package:projectb2b/screen/changepassword.dart';
import 'package:projectb2b/screen/paymentscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SharedPreferences prefs;
  late String address;
  late String editName;
  String? displayName = '';
  var activity = [];
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
    Widget profilePreview = Container(
      margin: const EdgeInsets.fromLTRB(40, 50, 40, 0),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('images/user.png'),
            radius: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$displayName',
                    style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 20)),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 30,
                  width: 109,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: ((context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor:
                                    const Color.fromARGB(255, 224, 232, 235),
                                title: const Text('Confirmation'),
                                titleTextStyle: const TextStyle(
                                    color: Color.fromARGB(255, 23, 22, 29),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600),
                                content:
                                    const Text('Are you sure want to Sign Out ?'),
                                contentTextStyle:
                                    const TextStyle(color: Color.fromARGB(255, 23, 22, 29)),
                                actions: [
                                  TextButton(
                                      style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size.zero),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.fromLTRB(
                                                  0, 0, 10, 10))),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No',
                                          style:
                                              TextStyle(color: Color.fromARGB(255, 23, 22, 29)))),
                                  TextButton(
                                      style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size.zero),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.fromLTRB(
                                                  0, 0, 10, 10))),
                                      onPressed: () {
                                        prefs.clear();
                                        // print(prefs.getString('token'));
                                        Navigator.pushAndRemoveUntil(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const Login();
                                        }), (Route<dynamic> route) => false);
                                      },
                                      child: const Text('Yes',
                                          style:
                                              TextStyle(color: Color.fromARGB(255, 23, 22, 29))))
                                ],
                              )));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: const StadiumBorder(),
                        elevation: 10),
                    child: Wrap(children: const [
                      Icon(
                        Icons.logout_rounded,
                        color: Color.fromARGB(255, 26, 25, 32),
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Text("Sign Out",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color.fromARGB(255, 26, 25, 32)))
                    ]),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );

    Widget editProfile = Container(
      height: 220,
      margin: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 23, 22, 29),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(0,2)
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            // name
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text("Display Name",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color.fromARGB(255, 224, 232, 235))),
                      const SizedBox(height: 10),
                      Text(
                        "$displayName",
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color.fromARGB(255, 224, 232, 235)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    width: 60,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: const StadiumBorder(),
                            elevation: 10),
                        onPressed: () {
                          showDialog(
                            context: context, 
                            builder: ((context) => AlertDialog(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              backgroundColor: const Color.fromARGB(255, 224, 232, 235),
                              title: const Text('Change Display Name',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Color.fromARGB(255, 26, 25, 32))),
                              content: SizedBox(
                                height: 35,
                                child: TextFormField(
                                  initialValue: '$displayName',
                                onChanged: (value) {
                                  editName = value;
                                },
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromARGB(255, 255, 255, 255),
                                contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                hintText: 'Name',
                                hintStyle: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(100, 0, 0, 0),
                                    fontSize: 12),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)),
                                // prefixIcon: Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                //   child: Icon(Icons.),
                                // )
                              ),
                              )),
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
                                  child: const Text('Cancel',
                                  style: TextStyle(
                                                color: Color.fromARGB(255, 23, 22, 29)))),
                                TextButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                                    minimumSize: MaterialStateProperty.all(Size.zero),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 0, 20, 10))),
                                  onPressed: (){}, 
                                  child: const Text('Ok',
                                  style: TextStyle(
                                                color: Color.fromARGB(255, 23, 22, 29))))
                              ],
                            )));
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color.fromARGB(255, 26, 25, 32)),
                        )),
                  )
                ],
              ),
            ),
            // email
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: const [
                      Text("Address",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color.fromARGB(255, 224, 232, 235))),
                      SizedBox(height: 10),
                      Text(
                        "-",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color.fromARGB(255, 224, 232, 235)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    width: 60,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: const StadiumBorder(),
                            elevation: 10),
                        onPressed: () {
                          showDialog(
                            context: context, 
                            builder: ((context) => AlertDialog(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              backgroundColor: const Color.fromARGB(255, 224, 232, 235),
                              title: const Text('Change Address',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Color.fromARGB(255, 26, 25, 32))),
                              content: SizedBox(
                                height: 35,
                                child: TextFormField(
                                onChanged: (value) {
                                   address = value;
                                },
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromARGB(255, 255, 255, 255),
                                contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                hintText: 'Address',
                                hintStyle: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(100, 0, 0, 0),
                                    fontSize: 12),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              )),
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
                                  child: const Text('Cancel',
                                  style: TextStyle(
                                                color: Color.fromARGB(255, 23, 22, 29)))),
                                TextButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                                    minimumSize: MaterialStateProperty.all(Size.zero),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 0, 20, 10))),
                                  onPressed: (){}, 
                                  child: const Text('Ok',
                                  style: TextStyle(
                                                color: Color.fromARGB(255, 23, 22, 29))))
                              ],
                            )));
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color.fromARGB(255, 26, 25, 32)),
                        )),
                  )
                ],
              ),
            ),
            // password
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: const [
                      Text("Password",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color.fromARGB(255, 224, 232, 235))),
                      SizedBox(height: 10),
                      Text(
                        "**********",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color.fromARGB(255, 224, 232, 235)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    width: 60,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: const StadiumBorder(),
                            elevation: 10),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: ((context) {
                            return const ChangePassword(check: 'profile');
                          })));
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color.fromARGB(255, 26, 25, 32)),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );

    Widget quota = Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 23, 22, 29),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(0,2)
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            // name
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: const [
                        Text("Remaining Quota",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Color.fromARGB(255, 224, 232, 235))),
                        SizedBox(height: 10),
                        Text(
                          "You can open : ",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color.fromARGB(255, 224, 232, 235)),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 20,
                        width: 60,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('100 URL Left',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color.fromARGB(255, 224, 232, 235))),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 20,
                        width: 70,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: const StadiumBorder(),
                                elevation: 10),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: ((context) {
                                return const PaymentScreen();
                              })));
                            },
                            child: const Text(
                              'More',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 26, 25, 32)),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 224, 232, 235),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [profilePreview, editProfile, quota],
            ),
          ),
        ),
      ),
    );
  }
}
