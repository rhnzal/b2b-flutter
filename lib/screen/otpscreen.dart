import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projectb2b/screen/changepassword.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String otp = '';
  final RoundedLoadingButtonController _buttonController = RoundedLoadingButtonController();

  void otpsend (RoundedLoadingButtonController controller){
    controller.success();
      Timer(const Duration(seconds: 1), (){
        Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return const ChangePassword(check: 'otp');
        })));
        controller.reset();
      });
  }

  @override
  Widget build(BuildContext context) {
    Widget tittle = Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Submit OTP', style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 24)),
          Text('Check your email for OTP', style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20))
        ],
      ),
    );

    Widget otpInput = Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          // prefixIcon: Image.asset('icons/email.png',height: 4 ),
          prefixIcon: const Icon(
            Icons.key,
            color: Colors.white,
          ),
          filled: true,
          fillColor: const Color.fromARGB(31, 217, 217, 217),
          contentPadding: const EdgeInsets.fromLTRB(30, 10, 20, 10),
          hintText: 'Enter OTP',
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
        otp = value;
      }),
    ));

    Widget submitOtp = Container(
      margin: const EdgeInsets.only(top: 40),
        child: RoundedLoadingButton(
          height: 35,
          width: 150,
          loaderSize: 20,
          color: const Color.fromARGB(255, 217, 217, 217),
          successColor:const Color.fromARGB(255, 217, 217, 217),
          valueColor: const Color.fromARGB(255, 27, 26, 32),
          controller: _buttonController,
          onPressed: () => otpsend(_buttonController),
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
        backgroundColor: Colors.transparent,
        elevation: 0,

    ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          tittle,
          otpInput,
          submitOtp
        ],
      ),
    );
  }
}