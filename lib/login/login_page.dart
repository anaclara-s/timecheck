import 'package:flutter/material.dart';

import 'widget/login_form_widget.dart';
import 'controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/timecheck_logo.png",
                fit: BoxFit.cover,
              ),
            ),
            LoginFormWidget(
              formKey: _loginController.fromKey,
              userController: _loginController.userController,
              passwordController: _loginController.passwordController,
              onLoginPressd: () => _loginController.makeLogin(context),
              isLoading: _loginController.isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
