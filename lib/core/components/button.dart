import 'package:ai_weather/core/theme/colors.dart';
import 'package:flutter/material.dart';

Widget myButton({
  double width = double.infinity,
  color = AppColors.primaryColor,
  bool isUpperCase = true,
  required VoidCallback? onPressed,
  required String text,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.surfaceColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: AppColors.textPrimaryColor,
          ),
        ),
      ),
    );
