import 'package:flutter/material.dart';

class ProductCounterWidget extends StatefulWidget {
  final int minNumber;
  final int initNumber;
  final Function(int) counterCallback;

  const ProductCounterWidget({
    super.key,
    required this.minNumber,
    required this.initNumber,
    required this.counterCallback,
  });

  @override
  State<ProductCounterWidget> createState() => _ProductCounterWidgetState();
}

class _ProductCounterWidgetState extends State<ProductCounterWidget> {
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
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      );
}
