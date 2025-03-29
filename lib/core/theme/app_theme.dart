import 'package:canteen/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    textTheme: AppTextTheme(),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      // ... other color scheme properties
    ),
  );

  static ThemeData darkTheme = ThemeData(
    textTheme: AppTextTheme().copyWithDarkMode(),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryVariant,
      // ... other color scheme properties
    ),
  );
}
