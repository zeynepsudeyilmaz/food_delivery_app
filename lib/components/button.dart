import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class Button extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final IconData? icon;

  const Button({
    super.key,
    required this.onPressed,
    required this.title,
    this.backgroundColor,
    this.foregroundColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 60.0),
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.backgroundColor ?? AppColors.primary;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 30,
            ),
          const SizedBox(
            width: 6,
          ),
          Text(
            title,
            style: TextStyle(
              color: foregroundColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
