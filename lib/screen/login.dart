import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projectb2b/endpoints.dart';
import 'package:projectb2b/home.dart';
import 'package:projectb2b/model/user.dart';
import 'package:projectb2b/screen/register.dart';
import 'package:projectb2b/screen/forgotpassword.dart';
import 'package:projectb2b/widget/alertdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:projectb2b/http.dart' as http_test;

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

  void login (RoundedLoadingButtonController controller) async {
    if (formKey.currentState!.validate()) {
      var response = await http_test.post(
        url: urlLogin, 
        body: {
          "email": email,
          "password": password
        }
      );
      
      if (response.isSuccess) {
        User user = User.fromJson(response.data);
        var token = response.data["token"];
        var displayName = user.fullName;
        var email = user.email;
        // print(avatar.last);
        prefs.setString('name', displayName);
        prefs.setString('token', token);
        prefs.setString('email', email);
        prefs.setString('pfp', user.avatar);
        
        controller.success();
        Timer(
          const Duration(seconds: 1), () {
            Navigator.pushReplacement(
              context, 
              PageTransition(
                child: const Home(), 
                type: PageTransitionType.rightToLeftWithFade,
                isIos: true
              )
            );
          }
        );

      } else {
        _buttonController.reset();
        var error = response.message;

        // Dialog
        showDialog(
          context: context,
          builder: (context) => MengDialog(
            title: 'Error', 
            content: error ?? 'error', 
            buttons: [
              MengDialogButton(
                text: 'OK', 
                onPressed: () {
                  passCon.clear();
                  Navigator.pop(context);
                }
              )
            ]
          )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget welcomeText = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.fromLTRB(15, 150, 15, 40)),
        Column(
          children: const[
            Text(
              'Welcome,',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 24)
            ),
            Text(
              'Sign In First',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20
              )
            )
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
            fontSize: 12
          ),
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
            borderRadius: BorderRadius.circular(20)
          )
        ),
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
              padding: MaterialStateProperty.all(EdgeInsets.zero)
            ),
            onPressed: () {
              Navigator.push(
                context, 
                PageTransition(
                  child: const ForgotPassword(), 
                  type: PageTransitionType.rightToLeftWithFade,
                  isIos: true
                )
              );
              emailCon.clear();
              passCon.clear();
            },
            child: const Text(
              'Forgot Your Password ?',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 11,
                color: Colors.white
              ),
            ),
          ),
        ),
      ],
    );

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
              fontSize: 14
            )
          ),
        ),
      )
    );

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
              color: Colors.white
            ),
          ),

          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              minimumSize: MaterialStateProperty.all(Size.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: MaterialStateProperty.all(EdgeInsets.zero)
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  child: const Register(), 
                  type: PageTransitionType.rightToLeftWithFade,
                  isIos: true
                )
              );

              _buttonController.reset();
              emailCon.clear();
              passCon.clear();
            },
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 11,
                color: Colors.white
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      // appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      backgroundColor: const Color.fromARGB(255, 23, 22, 29),
      // ignore: prefer_const_literals_to_create_immutables
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: Form(
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
      ),
    );
  }
}
 