import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_store_app/feature/cart/cart_bloc.dart';
import 'package:swag_store_app/feature/products/product_shimmer.dart';
import 'package:swag_store_app/feature/products/product_tile.dart';
import 'package:swag_store_app/feature/products/products_bloc.dart';
import 'package:swag_store_app/routes.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void didChangeDependencies() {
    context.read<ProductsBloc>().add(ProductsLoadingEvent());
    context.read<CartBloc>().add(CartInitEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: primary),
          onPressed: () => context.canPop() ? context.pop() : exit(0),
        ),
        title: Text(
          'Available SWAG',
          style:
              Theme.of(context).textTheme.titleLarge!.copyWith(color: primary),
        ),
        actions: context.canPop() ? [_cartMenuItem(context)] : null,
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (_, state) => switch (state) {
          ProductsEmptyState() => const Center(
              child: Text('No Products yet'),
            ),
          ProductsLoadingState() => ListView.builder(
              itemCount: 15,
              itemBuilder: (_, index) => const ProductShimmer(),
            ),
          ProductsLoadedState() => ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (_, index) => ProductTile(
                product: state.products[index],
              ),
            ),
        },
      ),
    );
  }

  _ProductsScreenState();

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
        onPressed: () => context.push('/${Routes.cart.name}'),
      );
}
