part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

class ProductsLoadedEvent extends ProductsEvent {
  final List<Product> products;

  ProductsLoadedEvent(this.products);
}

class ProductsLoadingEvent extends ProductsEvent {}
