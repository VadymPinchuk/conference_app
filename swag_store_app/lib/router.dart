import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_store_app/feature/cart/cart_screen.dart';
import 'package:swag_store_app/feature/products/products_screen.dart';
import 'package:swag_store_app/main_screen.dart';
import 'package:swag_store_app/routes.dart';

/// Single entry application route configuration.
final GoRouter mainRouter = GoRouter(
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
            return CartScreen(prevScreen: state.extra?.toString() ?? '/');
          },
        ),
      ],
    ),
  ],
);

/// Multiple entry application products route configuration.
final GoRouter productsRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (_, __) => const ProductsScreen(),
    ),
  ],
);

/// Multiple entry application cart route configuration.
final GoRouter cartRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (_, __) => const CartScreen(),
    ),
  ],
);
