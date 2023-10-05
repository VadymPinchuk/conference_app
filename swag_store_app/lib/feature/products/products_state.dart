part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

class ProductsEmptyState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsLoadedState extends ProductsState {
  final List<Product> products;

  ProductsLoadedState(this.products);
}
