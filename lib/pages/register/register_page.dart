import 'package:flutter/material.dart';

import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/custom_text_form_field.dart';
import 'controller/register_controller.dart';
import 'widget/email_fields.dart';
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
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormFieldWidget(
                controller: controller.nameController,
                hintText: 'Digite seu nome completo',
                validator: (value) =>
                    value!.isEmpty ? 'Informe seu nome' : null,
                onChanged: (value) {
                  setState(() {
                    controller.generateUsername(value);
                  });
                },
              ),
              const SizedBox(height: 12),
              UsernamePreview(username: controller.generatedUsername),
              const SizedBox(height: 16),
              EmailFields(
                emailController: controller.emailController,
                confirmEmailController: controller.confirmEmailController,
                emailError: controller.emailError,
                onChanged: () {
                  setState(() {
                    controller.validateEmail();
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormFieldWidget(
                controller: controller.passwordController,
                hintText: 'Crie sua senha',
                isPassword: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.isLoading
                    ? null
                    : () => controller.handleRegister(
                          formKey: _formKey,
                          context: context,
                          onUpdate: () => setState(() {}),
                        ),
                child: controller.isLoading
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
