import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swag_store_app/domain/models/product.dart';
import 'package:swag_store_app/feature/cart/cart_bloc.dart';
import 'package:swag_store_app/feature/products/product_counter_widget.dart';

class ProductTile extends StatefulWidget {
  final Product product;
  final int amount;

  const ProductTile({
    super.key,
    required this.product,
    this.amount = 0,
  });

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  var amount = 0;

  @override
  void didChangeDependencies() {
    amount = widget.amount;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;

    return BlocConsumer<CartBloc, CartState>(
      listenWhen: (previous, current) {
        return true;
      },
      listener: (context, state) {
        if (state is CartDataState) {
          setState(() {
            amount = state.selection[widget.product] ?? 0;
          });
        }
      },
      builder: (context, state) {
        var theme = Theme.of(context);
        return ListTile(
          leading: ClipOval(
            child: Image.network(
              widget.product.imageUrl,
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
            widget.product.name,
            maxLines: 1,
            style: theme.textTheme.titleMedium,
          ),
          subtitle: Text(
            _getSubtitle(),
            maxLines: 2,
            style: theme.textTheme.bodyMedium,
          ),
          trailing: ProductCounterWidget(
            minNumber: 0,
            initNumber: amount,
            counterCallback: (count) {
              context
                  .read<CartBloc>()
                  .add(CartChangeEvent(widget.product, count));
            },
          ),
          contentPadding: const EdgeInsets.all(8).copyWith(right: 0),
        );
      },
    );
  }

  String _getSubtitle() => '''${widget.product.sizes.toString()}
${widget.product.price} £''';
}
