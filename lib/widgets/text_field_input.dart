// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextFielsInput extends StatelessWidget {
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final bool isPassword;

  const TextFielsInput({
    required this.textController,
    required this.keyboardType,
    this.isPassword = false,
    required this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return TextField(
      controller: textController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        border: inputBorder,
        hintText: hintText,
        filled: true,
      ),
      keyboardType: keyboardType,
      obscureText: isPassword,
    );
  }
}
