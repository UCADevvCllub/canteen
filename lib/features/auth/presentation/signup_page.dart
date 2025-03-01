import 'package:canteen/presentation/widgets/buttons/app_button.dart';
import 'package:canteen/presentation/widgets/fields/app_text_form_field.dart';
import 'package:canteen/presentation/widgets/fields/role_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/utils/errors/validators.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>(); // Создаем ключ для формы
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? selectedRole; // Store the selected role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sign_up.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            // Оборачиваем в Form
            key: _formKey, // Передаем ключ формы
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
                  validator: FormValidators.validateName,
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  hintText: 'Email',
                  controller: emailController,
                  icon: Icons.email,
                  validator: FormValidators.validateEmail,
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  hintText: 'Password',
                  controller: passwordController,
                  icon: Icons.lock,
                  validator: FormValidators.validatePassword,
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                RoleDropdown(
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                AppButton(
                  title: 'Sign Up',
                  onPressed: () {
                    if (selectedRole == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a role')),
                      );
                    } else {}
                  },
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    context.router.pushNamed('/login');
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
