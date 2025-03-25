import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextButtonWidget extends StatefulWidget {
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
  State<CustomTextButtonWidget> createState() => _CustomTextButtonWidgetState();
}

class _CustomTextButtonWidgetState extends State<CustomTextButtonWidget> {
  @override
  Widget build(BuildContext context) {
    print('texto do botão recebido: ${widget.text}');
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: SizedBox(
        width: 250,
        height: 60,
        child: TextButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          child: widget.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                )
              : Text(
                  widget.text,
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
