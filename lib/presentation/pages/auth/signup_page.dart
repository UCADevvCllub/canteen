import 'package:canteen/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:canteen/presentation/widgets/role_dropdown.dart'; // Import the new dropdown file
import '../../widgets/app_text_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
              // Use the RoleDropdown widget here
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
                  // Perform sign-up logic
                  if (selectedRole == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a role')),
                    );
                  } else {
                    print('Name: ${nameController.text}');
                    print('Email: ${emailController.text}');
                    print('Role: $selectedRole');
                  }
                },
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