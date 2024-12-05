// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:canteen/presentation/pages/auth/login_page.dart' as _i2;
import 'package:canteen/presentation/pages/auth/signup_page.dart' as _i4;
import 'package:canteen/presentation/pages/home/home_page.dart' as _i1;
import 'package:canteen/presentation/pages/home/products/product_list_page.dart'
    as _i3;
import 'package:flutter/material.dart' as _i6;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginPage();
    },
  );
}

/// generated route for
/// [_i3.ProductListPage]
class ProductListRoute extends _i5.PageRouteInfo<ProductListRouteArgs> {
  ProductListRoute({
    _i6.Key? key,
    required String categoryTitle,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          ProductListRoute.name,
          args: ProductListRouteArgs(
            key: key,
            categoryTitle: categoryTitle,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductListRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductListRouteArgs>();
      return _i3.ProductListPage(
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

  final _i6.Key? key;

  final String categoryTitle;

  @override
  String toString() {
    return 'ProductListRouteArgs{key: $key, categoryTitle: $categoryTitle}';
  }
}

/// generated route for
/// [_i4.SignUpPage]
class SignUpRoute extends _i5.PageRouteInfo<void> {
  const SignUpRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SignUpPage();
    },
  );
}
