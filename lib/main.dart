import 'package:flutter/material.dart';
import 'package:timecheck/login/login_page.dart';
import 'package:timecheck/shared/constants.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: kLigthBackgroundColorPages,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: kStandardLightBackgroundColor,
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kDarkBackgroundColorPages,
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
          backgroundColor: kStandardDarkBackgroundColor,
        )),
      ),
      themeMode: ThemeMode.system,
      home: LoginPage(),
    ),
  );
}
