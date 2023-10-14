import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swag_store_app/data/mock_api.dart';
import 'package:swag_store_app/domain/shop_repository.dart';
import 'package:swag_store_app/feature/cart/cart_bloc.dart';
import 'package:swag_store_app/feature/products/products_bloc.dart';
import 'package:swag_store_app/router.dart';

void main() {
  Bloc.observer = _SwagStoreAppBlocObserver();
  runApp(SwagStoreApp(mainRouter));
}

@pragma('vm:entry-point')
void storeCart() {
  Bloc.observer = _SwagStoreAppBlocObserver();
  runApp(SwagStoreApp(cartRouter));
}

@pragma('vm:entry-point')
void storeProducts() {
  Bloc.observer = _SwagStoreAppBlocObserver();
  runApp(SwagStoreApp(productsRouter));
}

/// Bloc observer for logging purposes
class _SwagStoreAppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint(event?.toString());
    super.onEvent(bloc, event);
  }
}

class SwagStoreApp extends StatefulWidget {
  final RouterConfig<Object> _router;

  const SwagStoreApp(this._router, {super.key});

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
          routerConfig: widget._router,
          title: 'Not Official Swag Store',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: colorScheme,
          )
        ),
      ),
    );
  }
}
