import 'package:flutter/material.dart';

import 'label.dart';

class DhTextFormFiled extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String? initValue;
  final String hint;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onFieldSubmitted;
  final bool enabled;

  const DhTextFormFiled({
    Key? key,
    this.controller,
    required this.label,
    this.initValue,
    this.hint = '',
    this.enabled = true,
    this.validator,
    this.onChange,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Label(text: label),
        TextFormField(
          controller: controller,
          initialValue: initValue,
          enabled: enabled,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: const Color(0xFFF3F2F2),
            hintText: hint,
          ),
          onChanged: onChange,
          onFieldSubmitted: onFieldSubmitted,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
        )
      ],
    );
  }
}
