import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:canteen/features/auth/presentation/login_page.dart';
import 'package:canteen/features/auth/presentation/signup_page.dart';
import 'package:canteen/features/auth/presentation/splash_screen.dart';
import 'package:canteen/features/home/presentation/home_page.dart';
import 'package:canteen/features/profile/presentation/pages/profile_page.dart';
import 'package:canteen/features/schedule/presentation/pages/product_list_page.dart';
import 'package:canteen/features/schedule/presentation/admin/add_category.dart';
import 'package:canteen/features/recomendations/presentation/top_offers_page.dart';
import 'package:canteen/features/recomendations/presentation/most_popular_page.dart';
import 'package:canteen/features/discount/presentation/discount_page.dart';
import 'package:canteen/features/discount/presentation/recommendations_page.dart';
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
          page: LoginRoute.page,
          path: '/login',
          // initial: true,
        ),
        AutoRoute(
          page: SignUpRoute.page,
          path: '/sign-up',
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
        ),
        AutoRoute(
          page: ProfileRoute.page,
          path: '/profile',
        ),
        AutoRoute(
          page: ProductListRoute.page,
          path: '/product-list',
        ),
        AutoRoute(
          page: AddCategoryRoute.page,
          path: '/add-category',
        ),
        AutoRoute(
          page: TopOffersRoute.page,
          path: '/top-offers',
        ),
        AutoRoute(
          page: MostPopularRoute.page,
          path: '/most-popular',
        ),
      ];
}
