import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool obscureText;
  final bool isPasswordField;
  final String? labelText;
  final String? hintText;

  const CustomTextFormFieldWidget({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.isPasswordField = false,
    this.labelText,
    this.hintText,
  });

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  bool _showPassaword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: TextFormField(
        autofocus: true,
        controller: widget.controller,
        validator: widget.validator,
        onChanged: widget.onChanged,
        obscureText:
            widget.isPasswordField ? !_showPassaword : widget.obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: kTextFormFieldEnabledBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: kTextFormFieldFocusedBorderColor),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 20,
          ),
          hintText: widget.hintText,
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: Icon(
                    _showPassaword ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).hintColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassaword = !_showPassaword;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
