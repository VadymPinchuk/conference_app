part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

class ProductsLoadingEvent extends ProductsEvent {}
