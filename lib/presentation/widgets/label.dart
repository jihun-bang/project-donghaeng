import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String text;
  final TextStyle style;

  const Label(
      {Key? key,
      required this.text,
      this.style = const TextStyle(fontSize: 16, color: Colors.black)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: style),
    );
  }
}
