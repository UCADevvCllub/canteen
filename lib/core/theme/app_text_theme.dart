import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextTheme extends TextTheme {
  AppTextTheme({
    Color? displayColor,
    Color? bodyColor,
  }) : super(
    displayLarge: GoogleFonts.plusJakartaSans(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      color: displayColor ?? AppColors.onBackground,
      height: 1.12,
    ),
    displayMedium: GoogleFonts.plusJakartaSans(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      color: displayColor ?? AppColors.onBackground,
      height: 1.16,
    ),
    displaySmall: GoogleFonts.plusJakartaSans(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      color: displayColor ?? AppColors.onBackground,
      height: 1.22,
    ),
    headlineLarge: GoogleFonts.plusJakartaSans(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: displayColor ?? AppColors.onBackground,
      height: 1.25,
    ),
    headlineMedium: GoogleFonts.plusJakartaSans(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: displayColor ?? AppColors.onBackground,
      height: 1.29,
    ),
    headlineSmall: GoogleFonts.plusJakartaSans(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: displayColor ?? AppColors.onBackground,
      height: 1.33,
    ),
    titleLarge: GoogleFonts.plusJakartaSans(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: bodyColor ?? AppColors.onBackground,
      height: 1.27,
    ),
    titleMedium: GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: bodyColor ?? AppColors.onBackground,
      height: 1.50,
    ),
    titleSmall: GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: bodyColor ?? AppColors.onBackground,
      height: 1.43,
    ),
    bodyLarge: GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: bodyColor ?? AppColors.onBackground,
      height: 1.50,
    ),
    bodyMedium: GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: bodyColor ?? AppColors.onBackground,
      height: 1.43,
    ),
    bodySmall: GoogleFonts.plusJakartaSans(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: bodyColor ?? AppColors.onBackground,
      height: 1.33,
    ),
    labelLarge: GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: bodyColor ?? AppColors.onBackground,
      height: 1.43,
    ),
    labelMedium: GoogleFonts.plusJakartaSans(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: bodyColor ?? AppColors.onBackground,
      height: 1.33,
    ),
    labelSmall: GoogleFonts.plusJakartaSans(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: bodyColor ?? AppColors.onBackground,
      height: 1.45,
    ),
  );

  // Method to create a dark variant of the text theme
  AppTextTheme copyWithDarkMode() {
    return AppTextTheme(
      displayColor: Colors.white,
      bodyColor: Colors.white70,
    );
  }

  // Method to create a custom text style
  TextStyle customSubtitle({Color? color}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors.onBackground,
      letterSpacing: 0.15,
    );
  }
}