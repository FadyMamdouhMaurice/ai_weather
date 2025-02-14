import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFF6200EE);
  static const accentColor = Color(0xFF03DAC5);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(primary: primaryColor),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.dark(primary: primaryColor),
  );
}
