import 'package:flutter/material.dart';

Widget gradientText(String text) {
  final Shader linearGradientShader =
      const LinearGradient(colors: [Color(0xFF000046), Color(0xFF1CB5E0)])
          .createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  return Text(text,
      style: TextStyle(
          foreground: Paint()..shader = linearGradientShader,
          fontSize: 32,
          fontWeight: FontWeight.bold));
}
