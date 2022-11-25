import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MengStyle {
  Color colors;
  double size;

  MengStyle({this.colors = const Color.fromARGB(255, 23, 23, 23), this.size = 18});

  TextStyle get mengBig => TextStyle(
    color: colors,
    fontSize: size,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700
  );

  TextStyle get mengSmall => TextStyle(
    color: colors,
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400
  );
}

SystemUiOverlayStyle dark = const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark,
  // systemNavigationBarColor: Color.fromARGB(255, 0, 0, 0),
  // systemNavigationBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
);