import 'package:canteen/core/config/di.dart';
import 'package:canteen/core/theme/app_theme.dart';
import 'package:canteen/core/navigation/app_router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = locator<AppRouter>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Canteen',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      routerConfig: router.config(),
    );
  }
}
