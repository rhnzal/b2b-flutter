import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectb2b/endpoints.dart';
import 'package:projectb2b/home.dart';
import 'package:projectb2b/screen/register.dart';
import 'package:projectb2b/screen/forgotpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  bool _isObscure = true;
  final formKey = GlobalKey<FormState>();
  var loginStat = '';
  late bool isSuccess;
  late SharedPreferences prefs;
  final RoundedLoadingButtonController _buttonController = RoundedLoadingButtonController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    initpreference();
  }

  Future<void> initpreference() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  void login (RoundedLoadingButtonController controller) async{
                // ignore: empty_statements
                if (formKey.currentState!.validate()) {
                  var response = await http.post(
                      // Uri.parse("https://sija-b2b.ronisetiawan.id/api/auth/login"),
                      Uri.parse(urlLogin),
                      headers: {
                        HttpHeaders.contentTypeHeader: 'application/json'
                      },
                      body:
                          json.encode({"email": email, "password": password}));
                          // print(response.body);
                  isSuccess = json.decode(response.body)['isSuccess'];
                  if (isSuccess) {
                    // var username = json.decode(response.body)['data']['fullName'];
                    // prefs.setString('username', username);
                    // print(username);
                    var token = json.decode(response.body)['data']['token'];
                    var displayName = json.decode(response.body)['data']['fullName'];
                    prefs.setString('name', displayName);
                    prefs.setString('token', token);
                    controller.success();
                    Timer(const Duration(seconds: 1), (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: ((context) {
                      return const Home();
                    })));
                    });
                    // ignore: use_build_context_synchronously
                    //circular progress indicator
                  } else {
                    _buttonController.reset();
                    var error = json.decode(response.body)['message'];
                    // print(error);
                    showDialog(
                        
                        context: context,
                        builder: ((context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor:const Color.fromARGB(255, 224, 232, 235),
                              title: const Text('Error'),
                              titleTextStyle: const TextStyle(
                                  color: Color.fromARGB(255, 23, 22, 29),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600),
                              content: Text('$error'),
                              contentTextStyle: const TextStyle(color: Color.fromARGB(255, 23, 22, 29)),
                              actions: [
                                TextButton(
                                    style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        minimumSize: MaterialStateProperty.all(
                                            Size.zero),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.fromLTRB(0, 0, 10, 10))),
                                    onPressed: () {
                                      passCon.clear();
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(color: Color.fromARGB(255, 23, 22, 29),),
                                    )),
                              ],
                            )));
                  }
                  // print(response.body);
                  // print(isSuccess);

                  // print(mengege);
                  // print(loginStat);
                  // // print(loginStat);
                }
                //buat login
              
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable, avoid_unnecessary_containers
    Widget welcomeText = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.fromLTRB(15, 150, 15, 40)),
        Column(
          children: const[
            Text('Welcome,',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 24)),
            Text('Sign In First',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20))
          ],
        ),
      ],
    );

    Widget inputEmail = Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        controller: emailCon,
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          // prefixIcon: Image.asset('icons/email.png',height: 4 ),
          prefixIcon: const Icon(
            Icons.alternate_email,
            color: Colors.white,
          ),
          filled: true,
          fillColor: const Color.fromARGB(31, 217, 217, 217),
          contentPadding: const EdgeInsets.fromLTRB(30, 10, 20, 10),
          hintText: 'Email',
          hintStyle: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w200,
              color: Colors.white,
              fontSize: 12),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)),
          // prefixIcon: Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          //   child: Icon(Icons.),
          // )
        ),
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            _buttonController.reset();
            return "Please enter your email";
          } else if (!value.contains('@')) {
            _buttonController.reset();
            return "Please enter a valid email";
          }
          return null;
        },
      ),
    );

    Widget inputPassword = Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        controller: passCon,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        obscureText: _isObscure,
        decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.key,
              color: Colors.white,
            ),
            filled: true,
            fillColor: const Color.fromARGB(31, 217, 217, 217),
            contentPadding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
            hintText: 'Password',
            hintStyle: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w200,
                color: Colors.white,
                fontSize: 12),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
              icon: Icon(
                _isObscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.white,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20))),
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            _buttonController.reset();
            return "PLease Enter Your Password";
          } else if (value.length < 8) {
            _buttonController.reset();
            return "Password must be 8 character or more";
          }
          return null;
        },
      ),
    );

    Widget forgorPassword = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 180,
          child: TextButton(
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                minimumSize: MaterialStateProperty.all(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: MaterialStateProperty.all(EdgeInsets.zero)),
            // style: TextButton.styleFrom(
            //   padding: EdgeInsets.zero,
            //   minimumSize: Size.zero,
            //   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return const ForgotPassword();
              })));
              emailCon.clear();
              passCon.clear();
            },
            child: const Text(
              'Forgot Your Password ?',
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
    // ElevatedButton(
    //           style: ElevatedButton.styleFrom(
    //               primary: Color.fromARGB(255, 217, 217, 217),
    //               shape: StadiumBorder()),
    //           onPressed: () async {
    //             // ignore: empty_statements
    //             if (formKey.currentState!.validate()) {
    //               var response = await http.post(
    //                   Uri.parse("https://sija-b2b.ronisetiawan.id/api/auth/login"),
    //                   headers: {
    //                     HttpHeaders.contentTypeHeader: 'application/json'
    //                   },
    //                   body:
    //                       json.encode({"email": email, "password": password}));
    //               isSuccess = json.decode(response.body)['isSuccess'];
    //               if (isSuccess) {
    //                 // var username = json.decode(response.body)['data']['fullName'];
    //                 // prefs.setString('username', username);
    //                 // print(username);
    //                 var token = json.decode(response.body)['data']['token'];
    //                 var displayName = json.decode(response.body)['data']['fullName'];
    //                 prefs.setString('name', displayName);
    //                 prefs.setString('token', token);
    //                 // ignore: use_build_context_synchronously
    //                 //circular progress indicator
    //                 Navigator.pushReplacement(context,
    //                     MaterialPageRoute(builder: ((context) {
    //                   return Home();
    //                 })));
    //               } else {
    //                 var error = json.decode(response.body)['message'];
    //                 print(error);
    //                 showDialog(
    //                     context: context,
    //                     builder: ((context) => AlertDialog(
    //                           shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(10)),
    //                           backgroundColor: Color.fromARGB(255, 23, 22, 29),
    //                           title: Text('Error'),
    //                           titleTextStyle: TextStyle(
    //                               color: Colors.white,
    //                               fontFamily: 'Inter',
    //                               fontWeight: FontWeight.w600),
    //                           content: Text('$error'),
    //                           contentTextStyle: TextStyle(color: Colors.white),
    //                           actions: [
    //                             TextButton(
    //                                 style: ButtonStyle(
    //                                     overlayColor: MaterialStateProperty.all(
    //                                         Colors.transparent),
    //                                     minimumSize: MaterialStateProperty.all(
    //                                         Size.zero),
    //                                     tapTargetSize:
    //                                         MaterialTapTargetSize.shrinkWrap,
    //                                     padding: MaterialStateProperty.all(
    //                                         EdgeInsets.fromLTRB(0, 0, 10, 10))),
    //                                 onPressed: () {
    //                                   Navigator.pop(context);
    //                                 },
    //                                 child: Text(
    //                                   'OK',
    //                                   style: TextStyle(color: Colors.white),
    //                                 )),
    //                           ],
    //                         )));
    //               }
    //               print(response.body);
    //               print(isSuccess);

    //               // print(mengege);
    //               // print(loginStat);
    //               // // print(loginStat);
    //             }
    //             //buat login
    //           },
    //           child: Padding(
    //             padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
    //             child: Text('Sign In',
    //                 style: TextStyle(
    //                     fontFamily: 'Inter',
    //                     fontWeight: FontWeight.w700,
    //                     color: Color.fromARGB(255, 27, 26, 32),
    //                     fontSize: 14)),
    //           )),

    Widget loginButton = Container(
        margin: const EdgeInsets.only(top: 40),
        child: RoundedLoadingButton(
          height: 35,
          width: 150,
          loaderSize: 20,
          color: const Color.fromARGB(255, 217, 217, 217),
          successColor: const Color.fromARGB(255, 217, 217, 217),
          valueColor: const Color.fromARGB(255, 27, 26, 32),
          controller: _buttonController,
          onPressed: () => login(_buttonController),
          child: const Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Text('Sign In',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 27, 26, 32),
                      fontSize: 14)),
        ),
        ));

    Widget registerButton = Container(
      margin: const EdgeInsets.fromLTRB(0, 60, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Don\'t Have an Account ? ',
            style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 11,
                color: Colors.white),
          ),
          TextButton(
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                minimumSize: MaterialStateProperty.all(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: MaterialStateProperty.all(EdgeInsets.zero)),
            // style: TextButton.styleFrom(
            //   padding: EdgeInsets.zero,
            //   minimumSize: Size.zero,
            //   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                //api/users/login
                return const Register();
              }));
            },
            child: const Text(
              'Sign Up',
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );

    return Builder(
      builder: (context) {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light
        ));
        return Scaffold(
          // appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
          backgroundColor: const Color.fromARGB(255, 23, 22, 29),
          // ignore: prefer_const_literals_to_create_immutables
          body: Form(
            key: formKey,
            child: ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Colors.white,
                child: ListView(
                  children: [
                    welcomeText,
                    inputEmail,
                    inputPassword,
                    forgorPassword,
                    loginButton,
                    registerButton
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
