import 'package:flutter/material.dart';

class AppColors {
  final mainColor = Color(0xFF323232);
  final mainBgColor = Color(0xFFF5F5F5);
  final mainTextColor = Colors.white;
  final secondTextColor = Color(0xFF0F2027);
  final buttonShadowColor = Color(0xFF7287FE);
  final linearGradient = LinearGradient(
    colors: [
      Color(0xFFF5F5F5),
      Color(0xFFF5F5F5),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter
  );
  final buttonGradient = LinearGradient(
    colors: [
      Color(0xFF7287FE),
      Color(0xFF4E26F9),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft
  );
}