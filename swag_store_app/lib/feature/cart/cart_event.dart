part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartChangeEvent extends CartEvent {
  final Product product;
  final int count;

  CartChangeEvent(this.product, this.count);
}

class CartOrderMakingEvent extends CartEvent {}

class CartOrderedEvent extends CartEvent {}
