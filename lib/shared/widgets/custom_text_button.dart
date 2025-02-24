import 'package:flutter/material.dart';

class CustomTextButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomTextButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
        ),
      ),
    );
  }
}
