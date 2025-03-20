import 'package:flutter/material.dart';

import '../home/home_page.dart';
import '../services/auth_service.dart';
import '../shared/widgets/custom_text_button.dart';
import '../shared/widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _isLoading = false;

  Future<void> _makeLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final String usuario = _usuarioController.text;
      final String senha = _senhaController.text;

      final response = await AuthService.makeLogin(usuario, senha);

      setState(() {
        _isLoading = false;
      });

      if (response['sucess'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['mensage'])),
        );

        //login bem-sucedido
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['mensage'] ?? 'Erro desconhecido')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/timecheck_logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              CustomTextFormFieldWidget(
                labelText: 'Usuário',
                controller: _usuarioController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o usuário';
                  }
                  return null;
                },
              ),
              CustomTextFormFieldWidget(
                labelText: 'Senha',
                controller: _senhaController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a senha';
                  }
                  return null;
                },
              ),
              CustomTextButtonWidget(
                text: 'Login',
                onPressed: () => _makeLogin(context),
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
