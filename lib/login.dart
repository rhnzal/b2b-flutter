// ignore_for_file: prefer_const_literals_to_create_immutables, duplicate_ignore, prefer_const_constructors, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:projectb2b/register.dart';

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

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable, avoid_unnecessary_containers
    Widget welcomeText = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.fromLTRB(15, 150, 15, 40)),
        Column(
          children: [
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
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          // prefixIcon: Image.asset('icons/email.png',height: 4 ),
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
            email = value;
          });
        },
        validator: (value) {
          if(value!.isEmpty){
            return "Please enter your email";
          } else if(!value.contains('@')){
            return "Please enter a valid email";
          }
        },
      ),
    );

    Widget inputPassword = Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        obscureText: _isObscure,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.key,
              color: Colors.white,
            ),
            filled: true,
            fillColor: Color.fromARGB(31, 217, 217, 217),
            contentPadding: EdgeInsets.fromLTRB(30, 10, 0, 0),
            hintText: 'Password',
            hintStyle: TextStyle(
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
        validator :(value) {
          if(value!.isEmpty){
            return "PLease Enter Your Password";
          }else if(value.length < 8){
            return "Password must be 8 character or more";
          }
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
            onPressed: () {},
            child: Text(
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

    Widget loginButton = Container(
        margin: EdgeInsets.only(top: 40),
        child: Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 217, 217, 217),
                  shape: StadiumBorder()),
              onPressed: () {
                // ignore: empty_statements
                if(formKey.currentState!.validate());
                //buat login
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Text('Sign In',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 27, 26, 32),
                        fontSize: 14)),
              )),
        ));

    Widget registerButton = Container(
      margin: EdgeInsets.fromLTRB(0, 60, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return Register();
              }));
            },
            child: Text(
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

    return Scaffold(
      // appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      backgroundColor: const Color.fromARGB(255, 23, 22, 29),
      // ignore: prefer_const_literals_to_create_immutables
      body: Form(
        key: formKey,
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
    );
  }
}
