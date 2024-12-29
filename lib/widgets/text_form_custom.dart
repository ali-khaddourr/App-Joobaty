import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFormCustom extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Color? labelColor;
  final Color? hintColor;
  final IconData? suffixIcon ;
  final IconData? prefixIcon ;
  final Color? iconColor;
  final double? borderSize;
  final Color? borderColor;
  final Color? fillColor;
  final TextInputType? typeKeyboard;
  final bool? isFilled;
  final String? Function(String?)? validator;

  const TextFormCustom({
    Key? key,
    required this.controller, // controller يجب أن يكون إلزاميًا
    this.labelText,
    this.hintText,
    this.labelColor,
    this.hintColor,
    this.suffixIcon = null,
    this.prefixIcon = null,
    this.iconColor,
    this.borderSize,
    this.borderColor,
    this.fillColor,
    this.typeKeyboard,
    this.isFilled = false, // افتراضيًا ليست مملوءة
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(color: labelColor,fontSize: 12),
        hintStyle: TextStyle(color: hintColor,fontSize: 12),
        prefixIcon: Icon(suffixIcon, color: iconColor ?? labelColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? Colors.grey),
          borderRadius: BorderRadius.circular(borderSize ?? 8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? Colors.black),
          borderRadius: BorderRadius.circular(borderSize ?? 8.0),
        ),
        fillColor: fillColor,
        filled: isFilled,
      ),
      keyboardType: typeKeyboard,
      validator: validator, // استخدم المدقق الممرر
    );
  }
}
