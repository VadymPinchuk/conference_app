import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_store_app/domain/models/product.dart';
import 'package:swag_store_app/feature/cart/cart_bloc.dart';
import 'package:swag_store_app/feature/products/product_tile.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void didChangeDependencies() {
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
        title: Row(
          children: [
            Text(
              'SWAG',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: primary),
            ),
            const SizedBox(width: 16),
            Icon(
              Icons.shopping_cart,
              color: primary,
            ),
          ],
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (_, state) => switch (state) {
          CartLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
          CartEmptyState() => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 150,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nothing added to the cart, yet',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
            ),
          CartChangedState() => Column(
              children: [
                _productsList(state.selection),
                Row(
                  children: [
                    Expanded(child: Text('Total amount is: ${state.total}')),
                    ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () {},
                      child: const Text('Order items'),
                    ),
                  ],
                ),
              ],
            ),
          CartOrderPlacingState() => const Stack(
              children: [],
            ),
          CartOrderedState() => const Stack(
              children: [],
            ),
          _ => const Placeholder(),
        },
      ),
    );
  }

  Widget _productsList(Map<Product, int> selection) => Expanded(
        child: ListView.builder(
          itemCount: selection.length,
          itemBuilder: (_, index) {
            var product = selection.keys.toList()[index];
            return ProductTile(product: product, amount: selection[product]!);
          },
        ),
      );

  ButtonStyle get raisedButtonStyle => ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black87,
        minimumSize: const Size(88, 36),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      );
}
