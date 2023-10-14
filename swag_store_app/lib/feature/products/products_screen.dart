import 'dart:io';

import 'package:go_router/go_router.dart';
import 'package:swag_store_app/feature/cart/cart_bloc.dart';
import 'package:swag_store_app/feature/products/product_shimmer.dart';
import 'package:swag_store_app/feature/products/product_tile.dart';
import 'package:swag_store_app/feature/products/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swag_store_app/routes.dart';

class ProductsScreen extends StatelessWidget {
  final String prevScreen;

  const ProductsScreen({
    super.key,
    this.prevScreen = '',
  });

  @override
  Widget build(BuildContext context) {
    var primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: primary),
          onPressed: () =>
              prevScreen.isEmpty ? exit(0) : context.go('/$prevScreen'),
        ),
        title: Text(
          'Available SWAG',
          style:
              Theme.of(context).textTheme.titleLarge!.copyWith(color: primary),
        ),
        actions: [
          _cartMenuItem(context),
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (_, state) => switch (state) {
          ProductsEmptyState() => const Center(
              child: Text('No Products yet'),
            ),
          ProductsLoadingState() => AnimatedOpacity(
              opacity: 1,
              duration: const Duration(seconds: 2),
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (_, index) => const ProductShimmer(),
              ),
            ),
          ProductsLoadedState() => AnimatedOpacity(
              opacity: 1,
              duration: const Duration(seconds: 2),
              child: ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (_, index) => ProductTile(
                  product: state.products[index],
                ),
              ),
            ),
        },
      ),
    );
  }

  Widget _cartMenuItem(BuildContext context) {
    return BlocSelector<CartBloc, CartState, int>(
      selector: (state) {
        if (state is CartDataState) {
          return state.selection.entries
              .fold(0, (sum, item) => sum + item.value);
        }
        return 0;
      },
      builder: (context, prodCount) {
        if (prodCount == 0) {
          return _cartIcon(context);
        } else {
          return Badge(
            label: Text('$prodCount'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            alignment: AlignmentDirectional.topStart,
            child: _cartIcon(context),
          );
        }
      },
    );
  }

  Widget _cartIcon(BuildContext context) => IconButton(
        icon: const Icon(Icons.shopping_cart),
        onPressed: () =>
            context.go('/${Routes.cart.name}', extra: Routes.products.name),
      );
}
