import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle displaySmall = GoogleFonts.leagueSpartan(
    fontSize: 18,
    color: AppColors.textPrimary,
  );

  static TextStyle displayMedium = GoogleFonts.leagueSpartan(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
  );
  static TextStyle d1 = GoogleFonts.leagueSpartan(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static TextStyle bodyMedium = GoogleFonts.leagueSpartan(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
  );
  static TextStyle bodySmall = GoogleFonts.leagueSpartan(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
  );

  static TextStyle headlineLarge = GoogleFonts.leagueSpartan(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineMedium = GoogleFonts.leagueSpartan(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static TextStyle headline = GoogleFonts.leagueSpartan(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
  );
  static TextStyle headline2 = GoogleFonts.leagueSpartan(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
  static TextStyle appbarStyle = GoogleFonts.leagueSpartan(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
  );
}
