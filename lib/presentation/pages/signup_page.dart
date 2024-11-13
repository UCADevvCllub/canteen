// lib/presentation/pages/signup_page.dart
import 'package:flutter/material.dart';
import '../widgets/app_text_form_field.dart';
import 'home_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/signup.png'), // Ensure the image path matches your `pubspec.yaml` file
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                hintText: 'Full Name',
                controller: nameController,
                icon: Icons.person,
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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
