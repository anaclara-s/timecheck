import 'package:flutter/material.dart';
import 'package:timecheck/shared/widgets/custom_appbar.dart';
import 'package:timecheck/shared/widgets/custom_text_button.dart';
import 'package:timecheck/shared/widgets/custom_text_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
          bottom: 5,
        ),
        child: Column(
          children: [
            CustomTextFormFieldWidget(),
            CustomTextFormFieldWidget(),
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
