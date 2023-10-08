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
    return Material(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () => context.go(
                index == 0
                    ? '/${Routes.products.name}'
                    : '/${Routes.cart.name}',
                extra: ''),
            child: const Card(
              child: Column(
                children: [
                  // Expanded(child: Image.network(product.imageUrl)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
