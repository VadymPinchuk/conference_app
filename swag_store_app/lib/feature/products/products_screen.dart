import 'package:swag_store_app/feature/products/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available SWAG')),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (_, state) => switch (state) {
          ProductsEmptyState() => const Center(
              child: Text('No Products yet'),
            ),
          // TODO: Handle this case.
          ProductsLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
          // TODO: Handle this case.
          ProductsLoadedState() => ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (_, index) => ListTile(
                title: Text(state.products[index].name),
              ),
            ),
        },
      ),
    );
  }
}
