import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.validator,
    required this.onChanged,
    this.hintText,
    required this.obscureText,
    this.initialValue,
    this.labelText,
    required this.enabled,
    this.maxLines,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? hintText;
  final bool obscureText;
  final String? initialValue;
  final String? labelText;
  final bool enabled;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      initialValue: initialValue,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        labelText: labelText,
        enabled: enabled,
      ),
    );
  }
}
