import 'package:ai_weather_cellula/core/theme/gradient_theme_extension.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFF00488A);
  static const secondaryColor = Color(0xFF4EA3DB);
  static const backgroundColor = Color(0xFFF5F5F5);
  static const backgroundDarkColor = Color(0xFF121212);
  static const surfaceColor = Color(0xFFFFFFFF);
  static const surfaceDarkColor = Color(0xFF1E1E1E);
  static const errorColor = Color(0xFFB00020);
  static const textPrimaryColor = Color(0xFF212121);
  static const textSecondaryColor = Color(0xFF757575);
  static const textPrimaryDarkColor = Color(0xFFFFFFFF);
  static const textSecondaryDarkColor = Color(0xFFBDBDBD);
  static const borderColor = Color(0xFF000000);
  static const hintTextColor = Color(0xFF757575);
  static const gradientColor1 = Color(0xFFFFFFFF);
  static const gradientColor2 = Color(0xFF4EA3DB);
  static const gradientColor3 = Color(0xFF00488A);
  static const whiteColor = Color(0xFFFFFFFF);
  static const sunshineColor = Color(0xFFF5FE49);
  // Light theme configuration
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      background: backgroundColor,
      surface: surfaceColor,
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: textPrimaryColor,
      onSurface: textPrimaryColor,
      onError: Colors.white,
    ),
    extensions: const [
      GradientThemeExtension(
        backgroundGradient: LinearGradient(
          colors: [
            gradientColor1,
            gradientColor2,
            gradientColor3,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    ],
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textPrimaryColor),
      bodyMedium: TextStyle(color: textSecondaryColor),
    ),
  );

  // Dark theme configuration
  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundDarkColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      background: backgroundDarkColor,
      surface: surfaceDarkColor,
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: textPrimaryDarkColor,
      onSurface: textPrimaryDarkColor,
      onError: Colors.white,
    ),
    extensions: const [
      GradientThemeExtension(
        backgroundGradient: LinearGradient(
          colors: [
            backgroundDarkColor,
            backgroundDarkColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    ],
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textPrimaryDarkColor),
      bodyMedium: TextStyle(color: textSecondaryDarkColor),
    ),
  );
}