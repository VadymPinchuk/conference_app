import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swag_store_app/domain/models/product.dart';
import 'package:swag_store_app/feature/cart/cart_bloc.dart';
import 'package:swag_store_app/feature/products/product_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Icon(Icons.shopping_cart),
              SizedBox(width: 16),
              Text('SWAG Cart'),
            ],
          ),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (_, state) => switch (state) {
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
                        child: Text('Order items'),
                      ),
                    ],
                  ),
                ],
              ),
            CartOrderPlacingState() => Stack(
                children: [],
              ),
            CartOrderedState() => Stack(
                children: [],
              ),
            _ => Placeholder(),
          },
        ),
      );

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
        minimumSize: Size(88, 36),
        padding: EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      );
}
