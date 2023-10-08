import 'package:swag_store_app/data/mock_api.dart';
import 'package:swag_store_app/domain/shop_repository.dart';
import 'package:swag_store_app/feature/cart/cart_bloc.dart';
import 'package:swag_store_app/feature/cart/cart_screen.dart';
import 'package:swag_store_app/feature/products/products_bloc.dart';
import 'package:swag_store_app/feature/products/products_screen.dart';
import 'package:swag_store_app/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_store_app/routes.dart';

void main() {
  Bloc.observer = _SwagStoreAppBlocObserver();
  runApp(const SwagStoreApp());
}

/// Bloc observer for logging purposes
class _SwagStoreAppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint(event?.toString());
    super.onEvent(bloc, event);
  }
}


/// The route configuration.
final GoRouter _router = GoRouter(
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

class SwagStoreApp extends StatefulWidget {
  const SwagStoreApp({super.key});

  @override
  State<SwagStoreApp> createState() => _SwagStoreAppState();
}

class _SwagStoreAppState extends State<SwagStoreApp> {
  var colorScheme = ColorScheme.fromSeed(seedColor: Colors.purple);

  void _fetchTheme() async {
    var newColorScheme = await ColorScheme.fromImageProvider(
      provider: const NetworkImage(
          'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png'),
    );
    setState(() {
      colorScheme = newColorScheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    _fetchTheme();
    return RepositoryProvider(
      lazy: false,
      create: (_) => ShopRepository(MockApi()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductsBloc(
              RepositoryProvider.of<ShopRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => CartBloc(
              RepositoryProvider.of<ShopRepository>(context),
            ),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: _router,
          title: 'Not Official Swag Store',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: colorScheme,
          ),
        ),
      ),
    );
  }
}
