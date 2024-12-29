import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;

  final FontWeight? fontW;

  const TextCustom(
      {super.key,
      required this.text,
      this.color = Colors.black,
      this.size = 14,
      this.fontW = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${text}',
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontW,
      ),
    );
  }
}
