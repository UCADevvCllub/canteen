import 'package:auto_route/auto_route.dart';
import 'package:canteen/features/products/presentation/pages/add_product_page.dart';
import 'app_router.gr.dart';

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
      path: '/product-list/:categoryId',
    ),
    AutoRoute(
      page: AddProductRoute.page,
      path: '/add-product',
    ),
    AutoRoute(
      page: AddCategoryDialogWidget.page,
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