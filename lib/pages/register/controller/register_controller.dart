import 'package:flutter/material.dart';

import '../../../core/services/auth_service.dart';

class RegisterController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmEmailController = TextEditingController();
  final passwordController = TextEditingController();

  String generatedUsername = '';
  String? emailError;
  bool isLoading = false;

  void generateUsername(String fullName) {
    final names = fullName.trim().split(' ');
    if (names.length >= 2) {
      final first = names.first.toLowerCase();
      final last = names.last.toLowerCase();
      generatedUsername = '$first.$last';
    } else {
      generatedUsername = '';
    }
  }

  void validateEmail() {
    final email = emailController.text.trim();
    final confirm = confirmEmailController.text.trim();

    if (!_isValidEmail(email)) {
      emailError = 'Formato de e-mail inválido';
    } else if (email != confirm) {
      emailError = 'Os e-mails não coincidem';
    } else {
      emailError = null;
    }
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    confirmEmailController.dispose();
    passwordController.dispose();
  }

  Future<void> handleRegister({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required VoidCallback onUpdate,
  }) async {
    validateEmail();
    onUpdate();

    if (!formKey.currentState!.validate() || emailError != null) return;

    isLoading = true;
    onUpdate();

    final response = await AuthService.registerUser(
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    print('Resposta da API: $response');

    isLoading = false;
    onUpdate();

    if (response['sucess'] == true) {
      final usuario = response['usuario'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cadastro realizado! Usuário: $usuario')),
      );
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['mensage'] ?? 'Erro no cadastro')),
      );
    }
  }
}
