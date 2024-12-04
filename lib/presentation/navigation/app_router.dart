import 'package:auto_route/auto_route.dart';
import 'package:canteen/presentation/navigation/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
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
          initial: true
        ),
        AutoRoute(
          page: ProductListRoute.page,
          path: '/product-list',
        ),
      ];
}
