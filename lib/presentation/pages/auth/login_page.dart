import 'package:canteen/presentation/widgets/app_button.dart';
import 'package:canteen/presentation/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login_page.png'),
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
                Text(
                  'Login',
                  style: theme.textTheme.displayLarge,
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  hintText: 'Email',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                  controller: emailController,
                  icon: Icons.email,
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  hintText: 'Password',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  controller: passwordController,
                  icon: Icons.lock,
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                AppButton(
                  title: 'Login',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('Password: ${passwordController.text}');
                    }
                  },
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
      ),
    );
  }
}
