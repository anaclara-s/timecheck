import 'package:flutter/material.dart';

import '../../../core/services/auth_service.dart';
import '../../navigator_bar/navigation_bar_page.dart';

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

      if (!context.mounted) return;

      if (response['sucess'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['mensage'])),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationBarPage(
              userName: response['nome'],
              employeeId: response['id_funcionario'],
            ),
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
