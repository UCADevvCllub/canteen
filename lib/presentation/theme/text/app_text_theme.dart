import 'package:canteen/presentation/theme/colors/app_colors.dart';
import 'package:canteen/presentation/theme/dimens/dimens.dart';
import 'package:flutter/material.dart';

class AppTextTheme extends TextTheme {
  final Dimens dimens;
  final AppColors colors;

  AppTextTheme({
    required this.dimens,
    required this.colors,
  }) : super(
    displayLarge: TextStyle(
      fontSize: dimens.textDisplayLarge,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
    ),
    // Add more text styles here
  );
}
