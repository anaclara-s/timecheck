import 'package:flutter/material.dart';
import 'package:timecheck/login/login_page.dart';
import 'package:timecheck/shared/constants.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: kLigthBackgroundColorPages,
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kDarkBackgroundColorPages,
      ),
      themeMode: ThemeMode.system,
      home: LoginPage(),
    ),
  );
}
