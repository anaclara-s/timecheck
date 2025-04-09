import 'package:flutter/material.dart';

import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_text_form_field.dart';
import 'controller/register_controller.dart';
import 'widget/email_fields.dart';
import 'widget/password_fields.dart';
import 'widget/username_preview.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final controller = RegisterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(text: 'Cadastro'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormFieldWidget(
                controller: controller.nameController,
                prefixIcon: Icon(Icons.person_outline_sharp),
                hintText: 'Digite seu nome completo',
                validator: (value) =>
                    value!.isEmpty ? 'Informe seu nome' : null,
                onChanged: (value) {
                  setState(() {
                    controller.generateUsername(value);
                  });
                },
              ),
              UsernamePreviewWidget(username: controller.generatedUsername),
              EmailFieldsWidget(
                emailController: controller.emailController,
                confirmEmailController: controller.confirmEmailController,
                emailError: controller.emailError,
                onChanged: () {
                  setState(() {
                    controller.validateEmail();
                  });
                },
              ),
              PasswordFieldsWidget(
                passwordController: controller.passwordController,
                confirmPasswordController: controller.confirmPasswordController,
                passwordError: controller.passwordError,
                onChanged: () {
                  setState(() {
                    controller.validatePassword();
                  });
                },
              ),
              CustomElevatedButtonWidget(
                onPressed: controller.isLoading
                    ? null
                    : () => controller.handleRegister(
                          formKey: _formKey,
                          context: context,
                          onUpdate: () => setState(() {}),
                        ),
                text: 'Cadastrar',
                isLoading: controller.isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
