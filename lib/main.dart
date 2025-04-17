import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'core/constants/constants.dart';
import 'pages/login/login_page.dart';
import 'pages/register/register_page.dart';
import 'pages/welcome/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  Intl.defaultLocale = 'pt_BR';
  runApp(
    MaterialApp(
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: kLigthBackgroundColorPages,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kElevatedButtonLigthBackgroundColor,
                foregroundColor: kElevatedForegroundLigthBackgroundColor)),
        appBarTheme:
            const AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kDarkBackgroundColorPages,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kElevatedButtonDarkBackgroundColor,
                foregroundColor: kElevatedForegroundDarkBackgroundColor)),
      ),
      themeMode: ThemeMode.system,
    ),
  );
}
