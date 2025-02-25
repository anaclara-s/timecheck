import 'package:flutter/material.dart';
import 'package:timecheck/shared/constants.dart';

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
      child: SizedBox(
        width: 220,
        height: 60,
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: kLigthTextColors,
              fontSize: kSizeTexts,
            ),
          ),
        ),
      ),
    );
  }
}
