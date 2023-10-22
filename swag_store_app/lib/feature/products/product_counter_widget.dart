import 'package:flutter/material.dart';

class ProductCounterWidget extends StatelessWidget {
  final int value;
  final Function(int)? counterCallback;

  const ProductCounterWidget({
    super.key,
    required this.value,
    this.counterCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buttonWidget(
          context,
          Icons.remove,
          value == 0 || counterCallback == null
              ? null
              : () => counterCallback?.call(value - 1),
        ),
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        _buttonWidget(
          context,
          Icons.add,
          counterCallback == null
              ? null
              : () => counterCallback?.call(value + 1),
        ),
      ],
    );
  }

  Widget _buttonWidget(BuildContext context, IconData icon, onPressed) =>
      TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.secondary,
          ),
        ),
        onPressed: onPressed,
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      );
}
