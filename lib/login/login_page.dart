import 'package:flutter/material.dart';
import 'package:timecheck/shared/widgets/custom_text_button.dart';
import 'package:timecheck/shared/widgets/custom_text_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          CustomTextFormFieldWidget(),
          CustomTextFormFieldWidget(),
          CustomTextButtonWidget(
            onPressed: () {},
            text: 'Login',
          ),
        ],
      ),
    );
  }
}
