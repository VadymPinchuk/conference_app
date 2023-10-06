import 'package:swag_store_app/feature/products/product_tile.dart';
import 'package:swag_store_app/feature/products/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available SWAG'),
        actions: [
          _cartMenuItem(context),
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (_, state) => switch (state) {
          ProductsEmptyState() => const Center(
              child: Text('No Products yet'),
            ),
          ProductsLoadingState() => const Center(
              child: CircularProgressIndicator(),
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

  Widget _cartMenuItem(BuildContext context) {
    return Badge(
      alignment: AlignmentDirectional.topStart,
      child: _cartIcon(context),
    );
  }

  Widget _cartIcon(BuildContext context) => IconButton(
        icon: const Icon(Icons.shopping_cart),
        onPressed: () {
          // You can add an action here that will be triggered
          // when the cart icon is pressed
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cart icon tapped!')),
          );
        },
      );
}
