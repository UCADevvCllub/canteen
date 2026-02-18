import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/mixins/snackbar_helpers.dart';
import 'package:canteen/core/navigation/app_router.dart';
import 'package:canteen/core/theme/app_colors.dart';
import 'package:canteen/core/widgets/buttons/app_button.dart';
import 'package:canteen/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class EmailVerificationPage extends StatefulWidget {
  final String email;
  
  const EmailVerificationPage({
    super.key,
    required this.email,
  });

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> with SnackbarHelpers {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 100,
                    color: AppColors.darkGreen,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Verify your email',
                    style: theme.textTheme.headlineLarge!.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'We\'ve sent a verification email to:',
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.email,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGreen,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Please check your inbox and click on the verification link to activate your account.',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  authProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : AppButton(
                          title: 'Resend verification email',
                          color: AppColors.darkGreen,
                          onPressed: () async {
                            await authProvider.resendEmailVerification();
                            if (authProvider.errorMessage == null) {
                              showSuccessSnackBar(
                                context: context,
                                message: 'Verification email sent! Please check your inbox.',
                              );
                            } else {
                              showErrorSnackBar(
                                context: context,
                                message: authProvider.errorMessage!,
                              );
                            }
                          },
                        ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      context.router.replaceAll([LoginRoute()]);
                    },
                    child: Text(
                      'Back to login',
                      style: theme.textTheme.bodyMedium,
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

