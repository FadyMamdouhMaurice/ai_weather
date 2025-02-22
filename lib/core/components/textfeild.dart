import 'package:ai_weather_cellula/core/theme/colors.dart';
import 'package:flutter/material.dart';

Widget myTextFeild({
  Iterable<String>? autofill,
  TextEditingController? controller,
  required TextInputType keyboardType,
  required String lableText,
  IconData? suffixIcon,
  var onSuffixIconTap, // var not function because of null safety;
  bool isObscure = false,
  int? maxLength,
  bool readOnly = false,
  void Function(String)? onChanged, // add onChanged callback
  String? Function(String?)? validateFunction}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        autofillHints:autofill,
        maxLength: maxLength,
        validator: validateFunction,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isObscure,
        readOnly: readOnly,
        onChanged: (value) {
          onChanged?.call(value); // call onChanged callback
        },
        style: const TextStyle(color: AppColors.textPrimaryColor, fontSize: 20),
        decoration: InputDecoration(
          suffixIcon: suffixIcon != null
              ? IconButton(
            icon: Icon(
              suffixIcon,
            ),
            onPressed: onSuffixIconTap,
          ) : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.borderColor)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: AppColors.borderColor),
          ),
          hintText: lableText,
          hintStyle: const TextStyle(color: AppColors.hintTextColor, fontSize: 15),
        ),
      ),
    );