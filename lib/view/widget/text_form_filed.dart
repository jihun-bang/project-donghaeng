import 'package:flutter/material.dart';

import 'label.dart';

class DhTextFormFiled extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String hint;

  const DhTextFormFiled({
    Key? key,
    this.controller,
    required this.label,
    this.hint = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Label(text: label),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: const Color(0xFFF3F2F2),
            hintText: hint,
          ),
        )
      ],
    );
  }
}
