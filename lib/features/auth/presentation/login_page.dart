import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/mixins/snackbar_helpers.dart';
import 'package:canteen/core/navigation/app_router.dart';
import 'package:canteen/core/theme/app_colors.dart';
import 'package:canteen/core/widgets/buttons/app_button.dart';
import 'package:canteen/core/widgets/fields/app_text_form_field.dart';
import 'package:canteen/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SnackbarHelpers {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isCheckingAuth = true; // Track authentication check state
  bool _isEmailValid = false; // Track email validation state
  bool _isPasswordValid = false; // Track password validation state

  @override
  void initState() {
    super.initState();

    // Add listeners to the controllers
    emailController.addListener(_validateEmail);
    passwordController.addListener(_validatePassword);

    Future.microtask(() async {
      final authProvider = context.read<AuthProvider>();
      await authProvider.checkAuthentication();

      if (authProvider.isAuthenticated) {
        context.router.replaceAll([HomeRoute()]);
      } else {
        setState(() {
          _isCheckingAuth = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controllers
    emailController.removeListener(_validateEmail);
    passwordController.removeListener(_validatePassword);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Validate email input
  void _validateEmail() {
    final email = emailController.text.trim();
    setState(() {
      _isEmailValid = email.isNotEmpty && email.contains('@');
    });
  }

  // Validate password input
  void _validatePassword() {
    final password = passwordController.text.trim();
    setState(() {
      _isPasswordValid = password.isNotEmpty;
    });
  }

  // Validate all fields
  bool _validateFields() {
    return _isEmailValid && _isPasswordValid;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (_isCheckingAuth) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login_page.png'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: kToolbarHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome!',
                    style: theme.textTheme.headlineLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
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
                  authProvider.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : AppButton(
                          title: 'Login',
                          color: AppColors.darkGreen,
                          onPressed: () async {
                            if (_validateFields()) {
                              setState(() {}); // Refresh UI while loading
                              await authProvider.login(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );

                              if (authProvider.errorMessage == null) {
                                // Show success SnackBar
                                showSuccessSnackBar(
                                  context: context,
                                  message: 'Login successful!',
                                );
                                context.router.replaceAll([HomeRoute()]);
                              } else {
                                // Show error SnackBar
                                showErrorSnackBar(
                                  context: context,
                                  message: authProvider.errorMessage!,
                                );
                              }
                            } else {
                              // Show error SnackBar if fields are invalid
                              showErrorSnackBar(
                                context: context,
                                message: 'Please fill in all fields correctly',
                              );
                            }
                          },
                        ),
                  const SizedBox(height: kToolbarHeight * 2),
                  TextButton(
                    onPressed: () {
                      context.router.pushNamed('/sign-up');
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign up',
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: AppColors.darkGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
