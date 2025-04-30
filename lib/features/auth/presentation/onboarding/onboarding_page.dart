import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/navigation/app_router.dart';
import 'package:canteen/core/widgets/buttons/app_button.dart';
import 'package:canteen/features/auth/domain/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  final data = pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 40,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: kToolbarHeight),
                        Image.asset(
                          data.imagePath,
                          height: size.height * 0.35,
                        ),
                        Column(
                          children: [
                            Text(
                              data.title,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              data.subtitle,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SmoothPageIndicator(
                              controller: _controller,
                              count: pages.length,
                              effect: const WormEffect(
                                dotColor: Colors.grey,
                                activeDotColor: Color(0xFF58B96B),
                                dotHeight: 8,
                                dotWidth: 8,
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: AppButton(
                                onPressed: () {
                                  if (index == pages.length - 1) {
                                    context.router.replaceAll([LoginRoute()]);
                                  } else {
                                    _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                  }
                                },
                                title: index == pages.length - 1
                                    ? 'Get Started'
                                    : 'Next',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
