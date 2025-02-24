import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? hintText;

  const CustomTextFormFieldWidget({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText,
  });

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      controller: widget.controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
      ),
    );
  }
}
