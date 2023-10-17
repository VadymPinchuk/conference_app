import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swag_store_app/data/mock_api.dart';
import 'package:swag_store_app/data/mock_cache.dart';
import 'package:swag_store_app/domain/shop_repository.dart';
import 'package:swag_store_app/feature/cart/cart_bloc.dart';
import 'package:swag_store_app/feature/products/products_bloc.dart';
import 'package:swag_store_app/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = _SwagStoreAppBlocObserver();
  runApp(SwagStoreApp(mainRouter));
}

@pragma('vm:entry-point')
void storeCart() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = _SwagStoreAppBlocObserver();
  runApp(SwagStoreApp(cartRouter));
}

@pragma('vm:entry-point')
void storeProducts() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('$bloc changed from ${change.currentState} to ${change.nextState}');
    super.onChange(bloc, change);
  }
}

class SwagStoreApp extends StatefulWidget {
  final RouterConfig<Object> _router;

  const SwagStoreApp(this._router, {super.key});

  @override
  State<SwagStoreApp> createState() => _SwagStoreAppState();
}

class _SwagStoreAppState extends State<SwagStoreApp> {
  late Cache cache;

  @override
  void initState() {
    cache = Cache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => RepositoryProvider(
        lazy: false,
        create: (context) => ShopRepository(MockApi(), cache),
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
            theme: ThemeData.light(useMaterial3: true).copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF042B59),
              ),
            ),
            darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF027DFD),
                brightness: Brightness.dark,
              ),
            ),
          ),
        ),
      );
}
