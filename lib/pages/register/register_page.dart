import 'package:flutter/material.dart';

import '../../core/services/auth_service.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/custom_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();

  String? emailError;

  void _validateEmail() {
    final email = emailController.text.trim();
    final confirmEmail = confirmEmailController.text.trim();

    if (!_isValidEmail(email)) {
      setState(() => emailError = 'Formato de e-mail inválido');
    } else if (email != confirmEmail) {
      setState(() => emailError = 'Os e-mails não coincidem');
    } else {
      setState(() => emailError = null);
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  void dispose() {
    confirmEmailController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  String generatedUsername = '';

  void _generateUsername(String fullName) {
    final names = fullName.trim().split(' ');
    if (names.length >= 2) {
      final firstName = names.first.toLowerCase();
      final lastName = names.last.toLowerCase();
      setState(() {
        generatedUsername = '$firstName.$lastName';
      });
    } else {
      setState(() {
        generatedUsername = '';
      });
    }
  }

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final response = await AuthService.registerUser(
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (response['sucess']) {
      final usuario = response['usuario'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cadastro realizado! Usuário: $usuario')),
      );
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['mensage'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(text: 'Cadastro'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormFieldWidget(
                controller: nameController,
                hintText: 'Digite seu nome completo',
                validator: (value) =>
                    value!.isEmpty ? 'Informe seu nome' : null,
                onChanged: _generateUsername,
              ),
              const SizedBox(height: 12),
              if (generatedUsername.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Seu nome de usuário será:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 27, 63, 131),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        generatedUsername,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              CustomTextFormFieldWidget(
                controller: emailController,
                hintText: 'Digite seu email',
                validator: (value) =>
                    value!.isEmpty ? 'Informe seu email' : null,
                onChanged: (_) => _validateEmail(),
              ),
              const SizedBox(height: 12),
              CustomTextFormFieldWidget(
                controller: confirmEmailController,
                hintText: 'Confirme seu email',
                onChanged: (_) => _validateEmail(),
              ),
              if (emailError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    emailError!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              CustomTextFormFieldWidget(
                controller: passwordController,
                hintText: 'Crie sua senha',
                isPassword: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _register,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
