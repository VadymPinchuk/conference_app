import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swag_store_app/feature/products/product_counter_widget.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    return Shimmer.fromColors(
      baseColor: colors.primaryContainer,
      highlightColor: colors.secondaryContainer,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: colors.secondaryContainer,
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: colors.secondaryContainer,
            child: const Text(''),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: colors.secondaryContainer,
              child: const Text(
                '''
            ''',
                maxLines: 2,
              ),
            ),
          ),
        ),
        trailing: ProductCounterWidget(
          minNumber: 0,
          initNumber: 0,
          counterCallback: (count) {},
        ),
        contentPadding: const EdgeInsets.all(8).copyWith(right: 0),
      ),
    );
  }
}
