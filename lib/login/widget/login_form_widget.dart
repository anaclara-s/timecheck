import 'package:flutter/material.dart';

import '../../shared/widgets/custom_text_button.dart';
import '../../shared/widgets/custom_text_form_field.dart';

class LoginFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController userController;
  final TextEditingController passwordController;
  final VoidCallback onLoginPressd;
  final bool isLoading;

  const LoginFormWidget({
    super.key,
    required this.formKey,
    required this.userController,
    required this.passwordController,
    required this.onLoginPressd,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormFieldWidget(
            labelText: 'Usuário',
            controller: userController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o usuário';
              }
              return null;
            },
          ),
          CustomTextFormFieldWidget(
            labelText: 'Senha',
            controller: passwordController,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira a senha';
              }
              return null;
            },
          ),
          CustomTextButtonWidget(
            onPressed: onLoginPressd,
            isLoading: isLoading,
            text: 'Login',
          ),
        ],
      ),
    );
  }
}
