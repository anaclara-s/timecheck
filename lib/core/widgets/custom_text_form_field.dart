import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool obscureText;
  final bool isPassword;
  final String? labelText;
  final String? hintText;
  final bool? filled;
  final Color? fillColor;
  final Widget? prefixIcon;

  const CustomTextFormFieldWidget({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.isPassword = false,
    this.labelText,
    this.hintText,
    this.filled,
    this.fillColor,
    this.prefixIcon,
  });

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: TextFormField(
        autofocus: true,
        controller: widget.controller,
        validator: widget.validator,
        onChanged: widget.onChanged,
        obscureText: widget.isPassword ? !_showPassword : widget.obscureText,
        decoration: InputDecoration(
          filled: widget.filled,
          fillColor: widget.fillColor,
          prefixIcon: widget.prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: kTextFormFieldEnabledBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: kTextFormFieldFocusedBorderColor),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 20,
          ),
          hintText: widget.hintText,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).hintColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
