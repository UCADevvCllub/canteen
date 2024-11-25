import 'package:canteen/presentation/pages/home_page.dart';
import 'package:canteen/presentation/pages/auth/login_page.dart';
import 'package:canteen/presentation/pages/auth/signup_page.dart';
import 'package:canteen/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.lightTheme,
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/sign-up': (context) => const SignUpPage(),
      },
    );
  }
}

