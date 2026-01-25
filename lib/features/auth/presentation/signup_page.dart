import 'package:canteen/core/mixins/snackbar_helpers.dart';
import 'package:canteen/core/navigation/app_router.dart';
import 'package:canteen/core/theme/app_colors.dart';
import 'package:canteen/core/widgets/buttons/app_button.dart';
import 'package:canteen/core/widgets/fields/app_text_form_field.dart';
import 'package:canteen/core/widgets/fields/role_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:canteen/features/auth/presentation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SnackbarHelpers {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  String? selectedRole;
  bool _isNameValid = false; // Track name validation state
  bool _isEmailValid = false; // Track email validation state
  bool _isPasswordValid = false; // Track password validation state
  bool _isRepeatPasswordValid = false; // Track repeat password validation state

  @override
  void initState() {
    super.initState();

    // Add listeners to the controllers
    nameController.addListener(_validateName);
    emailController.addListener(_validateEmail);
    passwordController.addListener(_validatePassword);
    repeatPasswordController.addListener(_validateRepeatPassword);
  }

  @override
  void dispose() {
    // Clean up the controllers
    nameController.removeListener(_validateName);
    emailController.removeListener(_validateEmail);
    passwordController.removeListener(_validatePassword);
    repeatPasswordController.removeListener(_validateRepeatPassword);
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  // Validate name input
  void _validateName() {
    final name = nameController.text.trim();
    setState(() {
      _isNameValid = name.isNotEmpty;
    });
  }

  // Validate email input
  void _validateEmail() {
    final email = emailController.text.trim();
    setState(() {
      _isEmailValid = email.isNotEmpty && 
          email.contains('@') && 
          email.toLowerCase().endsWith('@ucentralasia.org');
    });
  }

  // Validate password input
  void _validatePassword() {
    final password = passwordController.text.trim();
    setState(() {
      _isPasswordValid = password.isNotEmpty && 
          password.length >= 6 && 
          password.contains(RegExp(r'[0-9]')) &&
          password.contains(RegExp(r'[a-zA-Z]'));
    });
  }

  // Validate repeat password input
  void _validateRepeatPassword() {
    final password = passwordController.text.trim();
    final repeatPassword = repeatPasswordController.text.trim();
    setState(() {
      _isRepeatPasswordValid = repeatPassword.isNotEmpty && 
          repeatPassword == password;
    });
  }

  // Validate all fields
  bool _validateFields() {
    return _isNameValid &&
        _isEmailValid &&
        _isPasswordValid &&
        _isRepeatPasswordValid &&
        selectedRole != null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: kToolbarHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Text(
                  'Sign Up',
                  style: theme.textTheme.displayMedium!.copyWith(
                    color: AppColors.primary,
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
                  hintText: 'email@ucentralasia.org',
                  controller: emailController,
                  icon: Icons.email,
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
                AppTextFormField(
                  hintText: 'Password',
                  controller: passwordController,
                  icon: Icons.lock,
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  hintText: 'Confirm Password',
                  controller: repeatPasswordController,
                  icon: Icons.lock,
                  isPassword: true,
                ),
                const SizedBox(height: kToolbarHeight),
                authProvider.isLoading
                    ? const CircularProgressIndicator()
                    : AppButton(
                        title: 'Sign Up',
                        color: AppColors.darkGreen,
                        onPressed: () async {
                          if (_validateFields()) {
                            // Check if passwords match
                            if (passwordController.text.trim() != repeatPasswordController.text.trim()) {
                              showErrorSnackBar(
                                context: context,
                                message: 'Passwords do not match',
                              );
                              return;
                            }
                            
                            await authProvider.register(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              name: nameController.text.trim(),
                              role: selectedRole!,
                            );

                            if (authProvider.errorMessage == null) {
                              showSuccessSnackBar(
                                context: context,
                                message: 'Verification email sent! Please check your inbox.',
                              );
                              context.router.push(
                                EmailVerificationRoute(email: emailController.text.trim()),
                              );
                            } else {
                              showErrorSnackBar(
                                context: context,
                                message: authProvider.errorMessage!,
                              );
                            }
                          } else {
                            String errorMessage = 'Please fill in all fields correctly';
                            if (!_isEmailValid && emailController.text.trim().isNotEmpty) {
                              errorMessage = 'Email must end with @ucentralasia.org';
                            } else if (!_isPasswordValid && passwordController.text.trim().isNotEmpty) {
                              final password = passwordController.text.trim();
                              if (password.length < 6) {
                                errorMessage = 'Password must be at least 6 characters long';
                              } else if (!password.contains(RegExp(r'[0-9]'))) {
                                errorMessage = 'Password must contain at least one number';
                              } else if (!password.contains(RegExp(r'[a-zA-Z]'))) {
                                errorMessage = 'Password must contain at least one letter';
                              } else {
                                errorMessage = 'Password must be at least 6 characters, contain a letter and a number';
                              }
                            } else if (!_isRepeatPasswordValid && repeatPasswordController.text.trim().isNotEmpty) {
                              errorMessage = 'Passwords do not match';
                            }
                            showErrorSnackBar(
                              context: context,
                              message: errorMessage,
                            );
                          }
                        },
                      ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    context.router.pushNamed('/login');
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account? ',
                          style: theme.textTheme.labelLarge!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Login',
                          style: theme.textTheme.labelLarge!.copyWith(
                            color: AppColors.darkGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
