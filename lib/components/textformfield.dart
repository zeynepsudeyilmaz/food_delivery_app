import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/app_colors.dart';

class Textformfield extends StatelessWidget {
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? hintText;
  final String? Function(String?)? validator;

  const Textformfield({
    super.key,
    this.obscureText = true,
    required this.controller,
    this.keyboardType,
    this.suffixIcon,
    this.validator,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextFormField(
        cursorColor: Colors.black,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          suffixIconColor: AppColors.primary,
          fillColor: Colors.transparent,
          filled: true,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        ),
        validator: validator,
      ),
    );
  }
}
