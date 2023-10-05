import 'package:swag_store_app/data/mock_api.dart';
import 'package:swag_store_app/domain/shop_repository.dart';
import 'package:swag_store_app/feature/products/products_bloc.dart';
import 'package:swag_store_app/feature/products/products_screen.dart';
import 'package:swag_store_app/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const SwagShopApp());
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
          path: 'products',
          builder: (BuildContext context, GoRouterState state) {
            return const ProductsScreen();
          },
        ),
      ],
    ),
  ],
);

class SwagShopApp extends StatefulWidget {
  const SwagShopApp({super.key});

  @override
  State<SwagShopApp> createState() => _SwagShopAppState();
}

class _SwagShopAppState extends State<SwagShopApp> {
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
              create: (context) =>
                  ProductsBloc(RepositoryProvider.of<ShopRepository>(context))),
          // BlocProvider(
          //   create: (context) => ProductsBloc(),
          // ),
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
