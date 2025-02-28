import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;

  const CustomTextButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: SizedBox(
        width: 220,
        height: 60,
        child: TextButton(
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ? CircularProgressIndicator()
              : Text(
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
