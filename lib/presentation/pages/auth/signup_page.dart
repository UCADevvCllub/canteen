import 'package:canteen/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_text_form_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/sign_up.png'),
            // Ensure the image path matches your `pubspec.yaml` file
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
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
              AppButton(
                title: 'Sign Up',
                onPressed: () {},
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
