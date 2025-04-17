import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/services/auth_service.dart';

class RegisterController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmEmailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();

  String generatedUsername = '';
  String? emailError;
  String? passwordError;
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

  void validatePassword() {
    final password = passwordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    if (password.length < 4) {
      passwordError = 'Senha precisa ter mais de 4 caracteres';
    } else if (password != confirm) {
      passwordError = 'As senhas não coincidem';
    } else {
      passwordError = null;
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

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Cadastro realizado',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Nome de usuário: $generatedUsername',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Senha: ${passwordController.text.trim()}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                final data =
                    'Usuário: $generatedUsername\nSenha: ${passwordController.text.trim()}';
                Clipboard.setData(ClipboardData(text: data));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Credenciais copiadas!')),
                );
              },
              icon: const Icon(Icons.copy),
              label: const Text('Copiar credenciais'),
            ),
            const SizedBox(height: 12),
            const Text(
              'Não compartilhe suas credenciais',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
