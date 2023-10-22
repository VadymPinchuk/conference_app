import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_store_app/domain/models/product.dart';
import 'package:swag_store_app/feature/cart/cart_bloc.dart';
import 'package:swag_store_app/feature/products/product_tile.dart';

import '../products/product_shimmer.dart';

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
          CartLoadingState() => ListView.builder(
              itemCount: 15,
              itemBuilder: (_, index) => const ProductShimmer(),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                            'Total amount is: ${state.total.toStringAsFixed(2)}'),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.resolveWith<double?>(
                            (Set<MaterialState> states) {
                              return states.contains(MaterialState.pressed)
                                  ? 16
                                  : null;
                            },
                          ),
                        ),
                        onPressed: () => context
                            .read<CartBloc>()
                            .add(CartOrderMakingEvent()),
                        child: const Text('Order items'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          CartOrderPlacingState() => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    'Placing your order',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
            ),
          CartOrderedState() => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_shopping_cart,
                    size: 150,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Order placed. Make new?',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
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
            return Dismissible(
              key: Key(product.imageUrl),
              background: Container(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                alignment: AlignmentDirectional.centerStart,
                child: _trashCanWidget(),
              ),
              secondaryBackground: Container(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                alignment: AlignmentDirectional.centerEnd,
                child: _trashCanWidget(),
              ),
              onDismissed: (_) => context.read<CartBloc>().add(
                    CartChangeEvent(product, 0),
                  ),
              child: ProductTile(product: product),
            );
          },
        ),
      );

  Padding _trashCanWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FaIcon(
        FontAwesomeIcons.trashCan,
        color: Theme.of(context).colorScheme.onTertiaryContainer,
      ),
    );
  }
}
