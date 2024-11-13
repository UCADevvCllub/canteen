import 'package:canteen/presentation/widgets/app_button.dart';
import 'package:canteen/presentation/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_page.png'),
            // Ensure the image path matches your `pubspec.yaml` file
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 35,
            right: 35,
            bottom: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                hintText: 'Email',
                controller: emailController,
                icon: Icons.email,
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                hintText: 'Password',
                controller: passwordController,
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 20),
              AppButton(
                title: 'Login',
                onPressed: () {},
              ),
              const SizedBox(height: 150),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sign-up');
                },
                child: const Text('Don\'t have an account? Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
