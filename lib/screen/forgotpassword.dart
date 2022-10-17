import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projectb2b/endpoints.dart';
import 'package:projectb2b/screen/otpscreen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  final RoundedLoadingButtonController _buttonController = RoundedLoadingButtonController();
  TextEditingController emailCon = TextEditingController();

  void otp(RoundedLoadingButtonController controller) async{
    if(formKey.currentState!.validate()){
      var respond = await http.post(Uri.parse(urlForgot),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: json.encode({
          "email": email
        })
      );
      var isSuccess = json.decode(respond.body)['isSuccess'];
      var message = json.decode(respond.body)['message'];
      if(isSuccess){
        controller.success();
          Timer(const Duration(seconds: 1), (){
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return const Otp();
            })));
            controller.reset();
            emailCon.clear();
          }
      );
      }else{
        showDialog(context: context, builder: ((context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          backgroundColor: const Color.fromARGB(255, 217, 217, 217),
          title: const Text('Error'),
          titleTextStyle: const TextStyle(
              color: Color.fromARGB(255, 23, 22, 29),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600),
          content: Text('$message'),
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
                  Navigator.pop(context);
                  emailCon.clear();
                  _buttonController.reset();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Color.fromARGB(255, 23, 22, 29)),
                )),
          ]
        )));
    }
  }}

  @override
  Widget build(BuildContext context) {
    Widget tittle = Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 0, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Enter Your Email', style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 24),),
          Text('We will send OTP to your email', style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20))
        ],
      ),
    );

    Widget emailInput = Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
        controller: emailCon,
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
          hintText: 'Enter Your Email',
          hintStyle:const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w200,
              color: Colors.white,
              fontSize: 12),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)),

      ),
      onChanged: ((value) {
        email = value;
      }),
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
    ));

    Widget otpSubmit = Container(
      margin: const EdgeInsets.only(top: 40),
        child: RoundedLoadingButton(
          height: 35,
          width: 150,
          loaderSize: 20,
          color: const Color.fromARGB(255, 217, 217, 217),
          successColor:const Color.fromARGB(255, 217, 217, 217),
          valueColor: const Color.fromARGB(255, 27, 26, 32),
          controller: _buttonController,
          onPressed: () => otp(_buttonController),
          child: const Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Text('Submit',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 27, 26, 32),
                      fontSize: 14)),
        ),
        )
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 22, 29),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            tittle,
            emailInput,
            otpSubmit
          ],
        ),
      ),
    );
  }
}