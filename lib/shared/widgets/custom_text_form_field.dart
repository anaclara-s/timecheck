import 'package:flutter/material.dart';
import 'package:timecheck/shared/constants.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? labelText;
  final String? hintText;

  const CustomTextFormFieldWidget({
    super.key,
    this.controller,
    this.onChanged,
    this.labelText,
    this.hintText,
  });

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: TextFormField(
        autofocus: true,
        controller: widget.controller,
        onChanged: widget.onChanged,
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
        ),
      ),
    );
  }
}
