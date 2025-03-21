import 'package:flutter/material.dart';
import 'package:timecheck/home/home_page.dart';
import 'package:timecheck/services/auth_service.dart';

class LoginController {
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> makeLogin(BuildContext context) async {
    if (fromKey.currentState!.validate()) {
      isLoading = true;

      final String user = userController.text;
      final String password = passwordController.text;

      final response = await AuthService.makeLogin(user, password);

      isLoading = false;

      if (response['sucess'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['mensage'])),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(userName: response['nome']),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['mensage'] ?? 'Erro desconhecido')),
        );
      }
    }
  }
}
