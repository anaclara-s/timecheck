import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'login/login_page.dart';
import 'core/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR');
  runApp(
    MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: kLigthBackgroundColorPages,
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                backgroundColor: kStandardLightBackgroundColor)),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kDarkBackgroundColorPages,
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                backgroundColor: kStandardDarkBackgroundColor)),
      ),
      themeMode: ThemeMode.system,
      home: LoginPage(),
    ),
  );
}
