import 'package:flutter/material.dart';

import '../../../core/widgets/custom_text_form_field.dart';

class PasswordFieldsWidget extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onChanged;
  final String? passwordError;

  const PasswordFieldsWidget({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onChanged,
    required this.passwordError,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormFieldWidget(
          controller: passwordController,
          prefixIcon: Icon(Icons.lock_outline),
          hintText: 'Crie sua senha',
          validator: (value) => value!.isEmpty ? 'Informe sua senha' : null,
          onChanged: (_) => onChanged(),
          isPassword: true,
        ),
        const SizedBox(height: 12),
        CustomTextFormFieldWidget(
          controller: confirmPasswordController,
          prefixIcon: Icon(Icons.lock_outline),
          hintText: 'Confirme sua senha',
          onChanged: (_) => onChanged(),
          isPassword: true,
        ),
        if (passwordError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              passwordError!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
