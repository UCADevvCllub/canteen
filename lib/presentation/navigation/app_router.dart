import 'package:auto_route/auto_route.dart';
import 'package:canteen/presentation/navigation/app_router.gr.dart';
import 'package:canteen/presentation/pages/home/products/product_list_page.dart';
import 'package:canteen/presentation/pages/home/recomendations/most_popular_page.dart';
import 'package:canteen/presentation/pages/home/recomendations/top_offers_page.dart';

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
