import 'package:canteen/presentation/pages/home_page.dart';
import 'package:canteen/presentation/pages/login_page.dart';
import 'package:canteen/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/sign-up': (context) => const SignUpPage(),
      },
    );
  }
}

