import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swag_store_app/domain/models/product.dart';
import 'package:swag_store_app/feature/cart/cart_bloc.dart';
import 'package:swag_store_app/feature/products/product_counter_widget.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;

    var theme = Theme.of(context);
    return ListTile(
      key: Key(product.id.toString()),
      leading: ClipOval(
        child: Image.network(
          product.imageUrl,
          width: 50,
          height: 50,
          loadingBuilder: (_, child, isLoading) {
            // return child when loaded, show progress when loading
            return isLoading == null
                ? child
                : Shimmer.fromColors(
                    baseColor: colors.primaryContainer,
                    highlightColor: colors.secondaryContainer,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: colors.secondaryContainer,
                    ),
                  );
          },
        ),
      ),
      tileColor: Theme.of(context).colorScheme.background,
      title: Text(
        product.name,
        maxLines: 1,
        style: theme.textTheme.titleMedium,
      ),
      subtitle: Text(
        _getSubtitle(),
        maxLines: 2,
        style: theme.textTheme.bodyMedium,
      ),
      contentPadding: const EdgeInsets.all(8).copyWith(right: 0),
      trailing: BlocSelector<CartBloc, CartState, int>(
        selector: (state) {
          if (state is CartDataState) {
            return state.selection[product] ?? 0;
          }
          return 0;
        },
        builder: (_, quantity) => ProductCounterWidget(
          key: Key(product.imageUrl),
          value: quantity,
          counterCallback: (count) {
            context.read<CartBloc>().add(CartChangeEvent(product, count));
          },
        ),
      ),
    );
  }

  String _getSubtitle() => '''${product.sizes.toString()}
${product.price} £''';
}
