// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:canteen/presentation/pages/auth/login_page.dart' as _i4;
import 'package:canteen/presentation/pages/auth/signup_page.dart' as _i7;
import 'package:canteen/presentation/pages/home/discounts/RecommendationsPage.dart'
    as _i2;
import 'package:canteen/presentation/pages/home/home_page.dart' as _i3;
import 'package:canteen/presentation/pages/home/products/admin/add_category.dart'
    as _i1;
import 'package:canteen/presentation/pages/home/products/product_list_page.dart'
    as _i6;
import 'package:canteen/presentation/pages/home/recomendations/most_popular_page.dart'
    as _i5;
import 'package:canteen/presentation/pages/home/recomendations/top_offers_page.dart'
    as _i8;
import 'package:flutter/material.dart' as _i10;

/// generated route for
/// [_i1.AddCategory]
class AddCategory extends _i9.PageRouteInfo<void> {
  const AddCategory({List<_i9.PageRouteInfo>? children})
      : super(
          AddCategory.name,
          initialChildren: children,
        );

  static const String name = 'AddCategory';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddCategory();
    },
  );
}

/// generated route for
/// [_i2.DiscountPage]
class DiscountRoute extends _i9.PageRouteInfo<void> {
  const DiscountRoute({List<_i9.PageRouteInfo>? children})
      : super(
          DiscountRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiscountRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.DiscountPage();
    },
  );
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.LoginPage();
    },
  );
}

/// generated route for
/// [_i5.MostPopularPage]
class MostPopularRoute extends _i9.PageRouteInfo<void> {
  const MostPopularRoute({List<_i9.PageRouteInfo>? children})
      : super(
          MostPopularRoute.name,
          initialChildren: children,
        );

  static const String name = 'MostPopularRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i5.MostPopularPage();
    },
  );
}

/// generated route for
/// [_i6.ProductListPage]
class ProductListRoute extends _i9.PageRouteInfo<ProductListRouteArgs> {
  ProductListRoute({
    _i10.Key? key,
    required String categoryTitle,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          ProductListRoute.name,
          args: ProductListRouteArgs(
            key: key,
            categoryTitle: categoryTitle,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductListRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductListRouteArgs>();
      return _i6.ProductListPage(
        key: args.key,
        categoryTitle: args.categoryTitle,
      );
    },
  );
}

class ProductListRouteArgs {
  const ProductListRouteArgs({
    this.key,
    required this.categoryTitle,
  });

  final _i10.Key? key;

  final String categoryTitle;

  @override
  String toString() {
    return 'ProductListRouteArgs{key: $key, categoryTitle: $categoryTitle}';
  }
}

/// generated route for
/// [_i7.SignUpPage]
class SignUpRoute extends _i9.PageRouteInfo<void> {
  const SignUpRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.SignUpPage();
    },
  );
}

/// generated route for
/// [_i8.TopOffersPage]
class TopOffersRoute extends _i9.PageRouteInfo<void> {
  const TopOffersRoute({List<_i9.PageRouteInfo>? children})
      : super(
          TopOffersRoute.name,
          initialChildren: children,
        );

  static const String name = 'TopOffersRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.TopOffersPage();
    },
  );
}
