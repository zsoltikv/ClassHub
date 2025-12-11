import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ---- LIGHT COLORS ----
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightPrimary    = Color(0xFF6C63FF);
  static const Color lightText       = Colors.black87;
  static const Color lightInputBg    = Colors.white;

  // ---- DARK COLORS ----
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkPrimary    = Color.fromARGB(255, 255, 255, 255);
  static const Color darkText       = Colors.white70;
  static const Color darkInputBg    = Color(0xFF1E1E1E);

  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color background(BuildContext context) =>
      _isDark(context) ? darkBackground : lightBackground;

  static Color primary(BuildContext context) =>
      _isDark(context) ? darkPrimary : lightPrimary;

  static Color text(BuildContext context) =>
      _isDark(context) ? darkText : lightText;

  static Color inputBackground(BuildContext context) =>
      _isDark(context) ? darkInputBg : lightInputBg;
}