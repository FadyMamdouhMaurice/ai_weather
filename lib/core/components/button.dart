import 'package:ai_weather/core/theme/colors.dart';
import 'package:flutter/material.dart';

Widget myButton({
  double width = double.infinity,
  Color = AppColors.primaryColor,
  bool isUpperCase = true,
  required Function onPressed,
  required String text,
}) =>
    Container(
      width: double.infinity,
      //color: AppColors.primaryColor,
      child: MaterialButton(
        onPressed: onPressed(),
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        //color: AppColors.primaryColor,
        color: Colors.white,
      ),
    );
