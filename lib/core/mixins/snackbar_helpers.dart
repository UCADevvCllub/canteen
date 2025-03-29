import 'package:flutter/material.dart';

mixin SnackbarHelpers {
  // Helper method to show a SnackBar
  void showSnackBar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    EdgeInsetsGeometry? margin,
    ShapeBorder? shape,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        duration: duration,
        backgroundColor: backgroundColor,
        behavior: behavior,
        margin: margin,
        shape: shape,
      ),
    );
  }

  // Helper method to show an error SnackBar
  void showErrorSnackBar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    showSnackBar(
      context: context,
      message: message,
      duration: duration,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  // Helper method to show a success SnackBar
  void showSuccessSnackBar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    showSnackBar(
      context: context,
      message: message,
      duration: duration,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
}
