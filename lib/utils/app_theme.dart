import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      appBarTheme: AppBarTheme(
          toolbarHeight: 100.0,
          iconTheme: IconThemeData(color: AppColors.textWhite),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          titleTextStyle: AppTextStyles.appbarStyle),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.inputBackground,
        filled: true,
      ),
      textTheme: TextTheme(
        displaySmall: AppTextStyles.displaySmall,
        displayMedium: AppTextStyles.displayMedium,
        bodyMedium: AppTextStyles.bodyMedium,
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
      ),
    );
  }
}
