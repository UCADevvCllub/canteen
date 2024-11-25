import 'package:canteen/presentation/theme/colors/app_colors.dart';
import 'package:canteen/presentation/theme/dimens/dimens.dart';
import 'package:canteen/presentation/theme/text/app_text_theme.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: AppTextTheme(
      dimens: Dimens(),
      colors: appColors,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
  );
}
