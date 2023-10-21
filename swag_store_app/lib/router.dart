import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_store_app/feature/cart/cart_screen.dart';
import 'package:swag_store_app/feature/products/products_screen.dart';
import 'package:swag_store_app/main_screen.dart';
import 'package:swag_store_app/routes.dart';

RouterConfig<Object> getRouter(String? path) => switch (path) {
      'products' => _productsRouter,
      'cart' => _cartRouter,
      _ => _mainRouter,
    };

/// Single entry application route configuration.
final GoRouter _mainRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: Routes.products.name,
          builder: (BuildContext context, GoRouterState state) {
            return const ProductsScreen();
          },
        ),
        GoRoute(
          path: Routes.cart.name,
          builder: (BuildContext context, GoRouterState state) {
            return const CartScreen();
          },
        ),
      ],
    ),
  ],
);

/// Multiple entry application products route configuration.
final GoRouter _productsRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (_, __) => const ProductsScreen(),
    ),
  ],
);

/// Multiple entry application cart route configuration.
final GoRouter _cartRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (_, __) => const CartScreen(),
    ),
  ],
);
