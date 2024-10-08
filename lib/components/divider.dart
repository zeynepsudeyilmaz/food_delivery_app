import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  final double thickness;
  final Color color;
  const MyDivider({super.key, required this.thickness, required this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      color: color,
    );
  }
}
