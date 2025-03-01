import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoginRoute.page,
          path: '/login',
          initial: true,
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
          page: ProductListRoute.page,
          path: '/product-list',
        ),
        AutoRoute(
          page: AddCategory.page, // ✅ Keep only this reference
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
