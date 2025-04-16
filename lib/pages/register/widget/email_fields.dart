import 'package:flutter/material.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class EmailFieldsWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController confirmEmailController;
  final String? emailError;
  final VoidCallback onChanged;

  const EmailFieldsWidget({
    super.key,
    required this.emailController,
    required this.confirmEmailController,
    required this.emailError,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormFieldWidget(
          controller: emailController,
          prefixIcon: const Icon(Icons.email_outlined),
          hintText: 'Digite seu email',
          validator: (value) => value!.isEmpty ? 'Informe seu email' : null,
          onChanged: (_) => onChanged(),
        ),
        const SizedBox(height: 12),
        CustomTextFormFieldWidget(
          controller: confirmEmailController,
          prefixIcon: const Icon(Icons.email_outlined),
          hintText: 'Confirme seu email',
          onChanged: (_) => onChanged(),
        ),
        if (emailError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              emailError!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
