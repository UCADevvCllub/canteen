import 'package:auto_route/auto_route.dart';
import 'package:canteen/features/auth/presentation/email_verification_page.dart';
import 'package:canteen/features/auth/presentation/login_page.dart';
import 'package:canteen/features/auth/presentation/onboarding/onboarding_page.dart';
import 'package:canteen/features/auth/presentation/signup_page.dart';
import 'package:canteen/features/auth/presentation/splash_screen.dart';
import 'package:canteen/features/discount/presentation/discount_page.dart';
import 'package:canteen/features/discount/presentation/most_popular_page.dart';
import 'package:canteen/features/discount/presentation/top_offers_page.dart';
import 'package:canteen/features/home/presentation/home_page.dart';
import 'package:canteen/features/products/presentation/pages/add_product_page.dart';
import 'package:canteen/features/products/presentation/pages/product_list_page.dart';
import 'package:canteen/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: OnboardingRoute.page,
          path: '/onboarding',
        ),
        AutoRoute(
          page: LoginRoute.page,
          path: '/login',
        ),
        AutoRoute(
          page: SignUpRoute.page,
          path: '/sign-up',
        ),
        AutoRoute(
          page: EmailVerificationRoute.page,
          path: '/email-verification',
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
        ),
        AutoRoute(
          page: ProductListRoute.page,
          path: '/product-list/:categoryId',
        ),
        AutoRoute(
          page: AddProductRoute.page,
          path: '/add-product',
        ),
        AutoRoute(
          page: TopOffersRoute.page,
          path: '/top-offers',
        ),
        AutoRoute(
          page: MostPopularRoute.page,
          path: '/most-popular',
        ),
        AutoRoute(
          page: ProfileRoute.page,
          path: '/profile',
        ),
      ];
}
