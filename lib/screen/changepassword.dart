import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projectb2b/screen/login.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:projectb2b/http.dart' as http_test;
import 'package:projectb2b/endpoints.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key, required this.check, this.email, this.otp}) : super(key: key);

  final String check;
  final String? email;
  final String? otp;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController passCon = TextEditingController();
  String newPass = '';
  final RoundedLoadingButtonController _buttonController = RoundedLoadingButtonController();
  bool _isObscure = true;
  bool _confirmObsecure = true;

  void enter (RoundedLoadingButtonController controller, String check) async{
    if(formKey.currentState!.validate()){
      var response = await http_test.put(
        url: urlChangePassword, 
        body: {
          "email" : widget.email,
          "otp" : widget.otp,
          "password": newPass
        }
      );
      // print(response.status);
      if(response.isSuccess){
        controller.success();
        Timer(const Duration(seconds: 1), (){
          showDialog(barrierDismissible: false,context: context, builder: ((context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
            backgroundColor:const Color.fromARGB(255, 224, 232, 235),
            title: const Text('Password has been changed'),
            titleTextStyle: const TextStyle(
              color: Color.fromARGB(255, 23, 22, 29),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600),
            actions: [
              TextButton(
                onPressed: (){
                  var count = 0;
                  check.contains('profile') ?
                  Navigator.popUntil(context, ((route) {
                    return count++ == 2;
                  }))
                  : Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) {
                    return const Login();
                  })), (route) => false); 
                }, 
                child: const Text('Ok',
                  style:TextStyle(color: Color.fromARGB(255, 23, 22, 29)))
                )
            ],
          )));
        });
      }else{
        controller.reset();
        showDialog(context: context, builder: ((context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
            backgroundColor:const Color.fromARGB(255, 224, 232, 235),
            title: const Text('Error'),
            titleTextStyle: const TextStyle(
              color: Color.fromARGB(255, 23, 22, 29),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600),
            content: Text(response.message!),
            contentTextStyle: const TextStyle(
              color: Color.fromARGB(255, 23, 22, 29)),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                child: const Text('Ok',
                  style:TextStyle(color: Color.fromARGB(255, 23, 22, 29)))
                )
            ],
          )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget tittle = Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Change Password', style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 24)),
          Text('Enter new password', style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20))
        ],
      ),
    );

    Widget newPassword = Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
        controller: passCon,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        obscureText: _isObscure,
        decoration: InputDecoration(
          // prefixIcon: Image.asset('icons/email.png',height: 4 ),
          prefixIcon: const Icon(
            Icons.key,
            color: Colors.white,
          ),
          filled: true,
          fillColor: const Color.fromARGB(31, 217, 217, 217),
          contentPadding: const EdgeInsets.fromLTRB(30, 10, 20, 10),
          hintText: 'Enter New Password',
          hintStyle:const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w200,
              color: Colors.white,
              fontSize: 12),
          suffixIcon: IconButton(
            onPressed: (){
              setState(() {
                _isObscure = !_isObscure;
              });
            }, 
            icon: Icon(
              _isObscure ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
              color: Colors.white
            ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)),
      ),
      onChanged: (value) {
        newPass = value;
      },
      validator: (value){
        if(value!.isEmpty){
          return 'Please enter your new password';
        }else if (value.length < 8) {
          _buttonController.reset();
          return "Password must be 8 character or more";
        }else{
          return null;
        }
      },
    ));

    Widget confirmPassword = Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        obscureText: _confirmObsecure,
        decoration: InputDecoration(
          // prefixIcon: Image.asset('icons/email.png',height: 4 ),
          prefixIcon: const Icon(
            Icons.lock,
            color: Colors.white,
          ),
          filled: true,
          fillColor: const Color.fromARGB(31, 217, 217, 217),
          contentPadding: const EdgeInsets.fromLTRB(30, 10, 20, 10),
          hintText: 'Confirm New Password',
          hintStyle:const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w200,
              color: Colors.white,
              fontSize: 12),
          suffixIcon: IconButton(
            onPressed: (){
              setState(() {
                _confirmObsecure = !_confirmObsecure;
              });
            }, 
            icon: Icon(
              _confirmObsecure ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
              color: Colors.white
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)),
      ),
      validator: ((value) {
        if(value!.isEmpty){
          _buttonController.reset();
          return 'Please confirm your new password';
        }else if(value != passCon.text){
          _buttonController.reset();
          return 'Pasword not match';
        }else {
          return null;
        }
      }),
    )
    );

    Widget submit = Container(
      margin: const EdgeInsets.only(top: 40),
        child: RoundedLoadingButton(
          height: 35,
          width: 150,
          loaderSize: 20,
          color: const Color.fromARGB(255, 217, 217, 217),
          successColor:const Color.fromARGB(255, 217, 217, 217),
          valueColor: const Color.fromARGB(255, 27, 26, 32),
          controller: _buttonController,
          onPressed: () => enter(_buttonController, widget.check),
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
      body: Form(
        key: formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            tittle,
            newPassword,
            confirmPassword,
            submit
          ],
        ),
      ),
      );
  }
}