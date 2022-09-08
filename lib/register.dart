// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, body_might_complete_normally_nullable, unrelated_type_equality_checks, empty_statements

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projectb2b/login.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String regname = '';
  String regemail = '';
  String regpas = '';
  bool _regpass = true;
  bool _conpass = true;
  final formKey = GlobalKey<FormState>();
  final _pasreg = TextEditingController();
  final _pascon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget welcomeRegister = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.fromLTRB(15, 150, 15, 40)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create New Account,',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 24)),
            Text('Please fill in the form to continue',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20))
          ],
        ),
      ],
    );

    Widget inputName = Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person_outline,
            color: Colors.white,
          ),
          filled: true,
          fillColor: Color.fromARGB(31, 217, 217, 217),
          contentPadding: EdgeInsets.fromLTRB(30, 10, 20, 10),
          hintText: 'Fullname',
          hintStyle: TextStyle(
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
            regname = value;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your name";
          }
        },
      ),
    );

    Widget regEmail = Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.alternate_email,
            color: Colors.white,
          ),
          filled: true,
          fillColor: Color.fromARGB(31, 217, 217, 217),
          contentPadding: EdgeInsets.fromLTRB(30, 10, 20, 10),
          hintText: 'Email',
          hintStyle: TextStyle(
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
            regemail = value;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your email";
          } else if (!value.contains('@')) {
            return "Please enter a valid email";
          }
        },
      ),
    );

    Widget regPassword = Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        cursorColor: Colors.white,
        controller: _pasreg,
        obscureText: _regpass,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.key,
              color: Colors.white,
            ),
            filled: true,
            fillColor: Color.fromARGB(31, 217, 217, 217),
            contentPadding: EdgeInsets.fromLTRB(30, 10, 20, 10),
            hintText: 'Password',
            hintStyle: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w200,
                color: Colors.white,
                fontSize: 12),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20)),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _regpass = !_regpass;
                });
              },
              icon: Icon(
                _regpass
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.white,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            )
            // prefixIcon: Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            //   child: Icon(Icons.),
            // )
            ),
        onChanged: (value) {
          setState(() {
            regpas = value;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "PLease Enter Your Password";
          } else if (value.length < 8) {
            return "Password must be 8 character or more";
          }
        },
      ),
    );

    Widget confirmPassword = Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        controller: _pascon,
        cursorColor: Colors.white,
        obscureText: _conpass,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            filled: true,
            fillColor: Color.fromARGB(31, 217, 217, 217),
            contentPadding: EdgeInsets.fromLTRB(30, 10, 20, 10),
            hintText: 'Confirm Password',
            hintStyle: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w200,
                color: Colors.white,
                fontSize: 12),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20)),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _conpass = !_conpass;
                });
              },
              icon: Icon(
                _conpass
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.white,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            )
            // prefixIcon: Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            //   child: Icon(Icons.),
            // )
            ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please confirm your password";
          } else if (value != _pasreg.text) {
            return "Password not match";
          } else {
            return null;
          }
        },
      ),
    );

    Widget regButton = Container(
        margin: EdgeInsets.only(top: 40),
        child: Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 217, 217, 217),
                  shape: StadiumBorder()),
              onPressed: () async{
                if (formKey.currentState!.validate()) {
                  var response = await http.post(Uri.parse("http://192.168.102.195:3000/api/users"),
                      headers: {
                        HttpHeaders.contentTypeHeader: 'application/json'
                      },
                      body: json.encode({
                        "fullName": regname,
                        "email": regemail,
                        "password": regpas,
                        "address": '' //cuma sementara addressnya masih not null
                      }));
                  print(response.body);
                  print(json.encode({
                        "fullName": regname,
                        "email": regemail,
                        "password": regpas,
                        "address": '' //cuma sementara addressnya masih not null
                      }));
                }
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Text('Sign Up',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 27, 26, 32),
                        fontSize: 14)),
              )),
        ));

    Widget loginButton = Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already Have an Account ? ',
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Login();
              }));
            },
            child: Text(
              'Sign In',
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 22, 29),
      body: Form(
        key: formKey,
        child: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: Colors.white,
            child: ListView(
              children: [
                welcomeRegister,
                inputName,
                regEmail,
                regPassword,
                confirmPassword,
                regButton,
                loginButton
              ],
            ),
          ),
        ),
      ),
    );
  }
}
