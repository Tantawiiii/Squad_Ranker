import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all<Color>(AppColors.buttonBackgroundColor),
        foregroundColor: WidgetStateProperty.all<Color>(AppColors.background),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 26.0,
          ),
        ),
        side: WidgetStateProperty.all<BorderSide>(
          const BorderSide(
            color: Colors.transparent,
          ),
        ),
        minimumSize: WidgetStateProperty.all<Size>(
          const Size(
            100.0,
            64.0,
          ),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          AppTextStyles.header24,
        ),
      ),
    ),
  );
}
