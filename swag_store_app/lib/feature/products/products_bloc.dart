import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swag_store_app/domain/models/product.dart';
import 'package:swag_store_app/domain/shop_repository.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ShopRepository _repository;

  ProductsBloc(this._repository) : super(ProductsEmptyState()) {
    on<ProductsLoadingEvent>((event, emit) async {
      if (state is! ProductsLoadedState) {
        emit(ProductsLoadingState());
        var products = await _repository.readProducts();
        if (products.isEmpty) {
          products = await _repository.fetchProducts();
          await _repository.saveProducts(products);
        }
        if (products.isEmpty) {
          emit(ProductsEmptyState());
        } else {
          emit(ProductsLoadedState(products));
        }
      }
    });
  }

  @override
  void onEvent(ProductsEvent event) {
    super.onEvent(event);
    debugPrint(event.toString());
  }
}
