import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/theme/app_colors.dart';
import 'package:canteen/core/utils/errors/validators.dart';
import 'package:canteen/presentation/widgets/buttons/app_button.dart';
import 'package:canteen/presentation/widgets/fields/app_text_form_field.dart';
import 'package:flutter/material.dart';

@RoutePage()
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login_page.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 35, right: 35, bottom: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 50), // Add space at the top
                  Text(
                    'Login',
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

                    // validator: FormValidators.validateEmail,
                  ),
                  const SizedBox(height: 20),
                  AppTextFormField(
                    hintText: 'Password',
                    validator: FormValidators.validatePassword,
                    controller: passwordController,
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    title: 'Login',
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      // }
                      context.router.pushNamed('/home');
                    },
                  ),
                  const SizedBox(height: 150),
                  TextButton(
                    onPressed: () {
                      // AuthService().signInWithEmailAndPassword(
                      //   emailController.text,
                      //   passwordController.text,
                      // );
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
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
