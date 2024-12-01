import 'package:canteen/core/di.dart';
import 'package:canteen/presentation/app.dart';
import 'package:flutter/material.dart';
import 'presentation/pages/auth/login_page.dart';
import 'package:canteen/presentation/widgets/navigation_bar.dart';


void main() {
  setupLocator();
  runApp(const App());
}
