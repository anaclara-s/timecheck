import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomElevatedButtonWidget extends StatefulWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final bool isEnabled;

  const CustomElevatedButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.isEnabled = true,
  });

  @override
  State<CustomElevatedButtonWidget> createState() =>
      _CustomElevatedButtonWidgetState();
}

class _CustomElevatedButtonWidgetState
    extends State<CustomElevatedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: SizedBox(
        width: 250,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
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
