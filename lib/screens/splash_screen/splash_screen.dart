import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/log_screens.dart/login_screen.dart';
import 'package:food_delivery_app/utils/app_colors.dart';
import 'package:food_delivery_app/utils/app_text_styles.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LogIn())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LineAwesomeIcons.hamburger_solid,
              size: 200,
              color: AppColors.primary,
            ),
            Text(
              "FOOD DELIVERY",
              style: AppTextStyles.headline2,
            )
          ],
        ),
      ),
    );
  }
}
