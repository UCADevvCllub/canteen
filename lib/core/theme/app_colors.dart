import 'package:flutter/material.dart';

class AppColors {
  // Primary color palette
  static const Color primaryVariant = Color(0xFF274119);
  static const Color secondary = Color(0xFFF88F17);
  static const Color secondaryVariant = Color(0xFFa45a05);

  static const Color primary = Color(0xFF84C264);

  static const MaterialColor primarySwatch = MaterialColor(
    0xFF84C264, // Base color
    <int, Color>{
      50: Color(0xFFEAF4E4), // Lightest shade
      100: Color(0xFFD5E9C9), // Lighter shade
      200: Color(0xFFBFDDAE), // Light shade
      300: Color(0xFFA9D193), // Slightly lighter than base
      400: Color(0xFF94C778), // Close to base
      500: Color(0xFF84C264), // Base color
      600: Color(0xFF77B05A), // Slightly darker than base
      700: Color(0xFF699E50), // Dark shade
      800: Color(0xFF5C8C46), // Darker shade
      900: Color(0xFF4E7A3C), // Darkest shade
    },
  );

  // Neutral colors
  // static const Color background = Color(0xFFFFFFFF);
  // static const Color surface = Color(0xFFFFFFFF);
  // static const Color error = Color(0xFFB00020);
  //
  // // Text colors
  // static const Color onPrimary = Colors.white;
  // static const Color onSecondary = Colors.black;
  static const Color onBackground = Colors.black;
  // static const Color onSurface = Colors.black;
  // static const Color onError = Colors.white;
  //
  // // Additional custom colors
  // static const Color lightGray = Color(0xFFF5F5F5);
  // static const Color darkGray = Color(0xFF9E9E9E);

  static const Color darkGreen = Color(0xFF228C22);
}
