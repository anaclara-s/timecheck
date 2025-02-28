import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../shared/widgets/custom_text_button.dart';
import '../shared/widgets/custom_text_form_field.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  Future<void> _makeLogin(BuildContext context) async {
    final String usuario = _usuarioController.text;
    final String senha = _senhaController.text;

    final response = await AuthService.makeLogin(usuario, senha);

    if (response['sucess']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['mensage'])),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['mensage'])),
      );
    }
  }

  LoginPage({super.key});

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
            Container(
              width: 270,
              height: 270,
              decoration: BoxDecoration(
                //color: const Color.fromARGB(66, 179, 183, 230),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/timecheck_logo.png",
                  // width: 200,
                  // height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            CustomTextFormFieldWidget(
              labelText: 'Usuário',
            ),
            CustomTextFormFieldWidget(
              labelText: 'Senha',
            ),
            CustomTextButtonWidget(
              onPressed: () {},
              text: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
