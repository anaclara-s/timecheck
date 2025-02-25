import 'package:flutter/material.dart';
import 'package:timecheck/shared/widgets/custom_text_button.dart';
import 'package:timecheck/shared/widgets/custom_text_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
