part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

class CartLoadingState extends CartState {}

/// Abstract State to hold all the data about selected products and total amount
abstract class CartDataState extends CartState {
  late final Map<Product, int> selection;
  late final double total;
}

class CartEmptyState extends CartDataState {
  CartEmptyState() {
    super.selection = <Product, int>{};
    super.total = 0;
  }
}

class CartChangedState extends CartDataState {
  CartChangedState(Map<Product, int> selection) {
    super.selection = selection;
    super.total = selection.getTotal();
  }
}

class CartOrderPlacingState extends CartState {
  final Order order;

  CartOrderPlacingState(this.order);
}

class CartOrderedState extends CartState {
  final Order order;

  CartOrderedState(this.order);
}
