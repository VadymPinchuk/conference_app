
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_store_app/feature/products/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_store_app/routes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductsBloc>().add(ProductsLoadingEvent());
    var query = MediaQuery.of(context);
    var size = query.size;
    var padding = query.padding;
    return Material(
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio:
            size.width / (size.height - padding.top - padding.bottom),
        children: _buildGridWidgets(context),
      ),
    );
  }

  List<Widget> _buildGridWidgets(BuildContext context) {
    final list = List<Widget>.empty(growable: true);
    final scheme = Theme.of(context).colorScheme;
    list.add(
      _itemWidget(FontAwesomeIcons.gamepad, 'Products', scheme.inversePrimary,
          () => context.go('/${Routes.products.name}', extra: '')),
    );
    list.add(
      _itemWidget(Icons.dangerous, 'Cart', Colors.red,
          () => context.go('/${Routes.cart.name}', extra: '')),
    );
    list.add(
      _itemWidget(Icons.dangerous, 'Cart', scheme.inversePrimary,
          () => context.go('/${Routes.cart.name}', extra: '')),
    );
    list.add(
      _itemWidget(Icons.dangerous, 'Cart', scheme.background,
          () => context.go('/${Routes.cart.name}', extra: '')),
    );
    list.add(
      _itemWidget(Icons.dangerous, 'Cart', scheme.background,
          () => context.go('/${Routes.cart.name}', extra: '')),
    );
    list.add(
      _itemWidget(Icons.dangerous, 'Cart', scheme.background,
          () => context.go('/${Routes.cart.name}', extra: '')),
    );
    list.add(
      _itemWidget(Icons.dangerous, 'Cart', scheme.background,
          () => context.go('/${Routes.cart.name}', extra: '')),
    );
    list.add(
      _itemWidget(Icons.dangerous, 'Cart', scheme.background,
          () => context.go('/${Routes.cart.name}', extra: '')),
    );
    list.add(
      _itemWidget(Icons.dangerous, 'Cart', scheme.background,
          () => context.go('/${Routes.cart.name}', extra: '')),
    );
    return list;
  }

  Widget _itemWidget(
          IconData icon, String title, Color color, Function() onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color,
                child: FaIcon(
                  icon,
                ),
              ),
              const SizedBox(height: 8),
              Text(title),
            ],
          ),
        ),
      );
}
