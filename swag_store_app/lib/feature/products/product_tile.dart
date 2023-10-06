import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swag_store_app/domain/models/product.dart';
import 'package:swag_store_app/feature/cart/cart_bloc.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final int amount;

  const ProductTile({
    super.key,
    required this.product,
    this.amount = 0,
  });

  @override
  Widget build(BuildContext context) => BlocSelector<CartBloc, CartState, int>(
        selector: (state) {
          if (state is CartDataState) {
            return state.selection[product] ?? 0;
          }
          return 0;
        },
        builder: (context, quantity) {
          return ListTile(
            leading: ClipOval(
              child: Image.network(product.imageUrl),
            ),
            title: Text(product.name, maxLines: 1),
            subtitle: Text(
              'Price: ${product.price} Sizes: ${product.sizes.toString()}',
              maxLines: 1,
            ),
            trailing: CounterView(
              minNumber: quantity,
              initNumber: amount,
              counterCallback: (count) {
                context.read<CartBloc>().add(CartChangeEvent(product, count));
              },
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          );
        },
      );
}

class CounterView extends StatefulWidget {
  final int minNumber;
  final int initNumber;
  final Function(int) counterCallback;

  const CounterView({
    super.key,
    required this.minNumber,
    required this.initNumber,
    required this.counterCallback,
  });

  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late int _minNumber;
  late int _currentCount;
  late Function _counterCallback;

  @override
  void initState() {
    _currentCount = widget.initNumber;
    _counterCallback = widget.counterCallback;
    _minNumber = widget.minNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _createIncrementDecrementButton(Icons.remove, () => _decrement()),
        Text(
          _currentCount.toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        _createIncrementDecrementButton(Icons.add, () => _increment()),
      ],
    );
  }

  void _increment() {
    setState(() {
      _currentCount++;
      _counterCallback(_currentCount);
    });
  }

  void _decrement() {
    setState(() {
      if (_currentCount > _minNumber) {
        _currentCount--;
        _counterCallback(_currentCount);
      }
    });
  }

  Widget _createIncrementDecrementButton(IconData icon, onPressed) =>
      TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.secondary),
        ),
        onPressed: onPressed,
        child: Icon(icon),
      );
}
