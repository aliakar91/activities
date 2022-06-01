import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromRGBO(181, 52, 113, 4);
  static const Color secondary = Color.fromRGBO(237, 76, 103, 4);
  static const Color textColor1 = Color.fromRGBO(18, 114, 167, 4);
  static const Color textColor2 = Color.fromRGBO(0, 98, 102, 4);
  static const Color textColor3 = Color.fromRGBO(27, 20, 100, 4);

  static const Color blackColor1 = Color(0xff9f9f9f);
  static const Color blackColor2 = Color(0xff7f7f7f);
  static const Color blackColor3 = Color(0xff5f5f5f);
  static const Color blackColor4 = Color(0xff3f3f3f);
  static const Color blackColor5 = Color(0xff1f1f1f);

  static const Color whiteColor1 = Color(0xfff9f9f9);
  static const Color whiteColor2 = Color(0xfff7f7f7);
  static const Color whiteColor3 = Color(0xfff5f5f5);
  static const Color whiteColor4 = Color(0xfff3f3f3);
  static const Color whiteColor5 = Color(0xfff1f1f1);

  static ThemeData appTheme = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: primary),
    buttonColor: secondary,
    primaryColor: primary,
    scaffoldBackgroundColor: whiteColor5,
  );
}
