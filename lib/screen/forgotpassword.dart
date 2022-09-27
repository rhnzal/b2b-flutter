import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projectb2b/screen/otpscreen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = '';
  final RoundedLoadingButtonController _buttonController = RoundedLoadingButtonController();

  void otp(RoundedLoadingButtonController controller){
    controller.success();
      Timer(const Duration(seconds: 1), (){
        Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return const Otp();
        })));
        controller.reset();
      });
  }

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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          tittle,
          emailInput,
          otpSubmit
        ],
      ),
    );
  }
}