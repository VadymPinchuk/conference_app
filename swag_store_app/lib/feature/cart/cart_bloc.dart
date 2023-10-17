import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swag_store_app/domain/models/order.dart';
import 'package:swag_store_app/domain/models/product.dart';
import 'package:swag_store_app/domain/shop_repository.dart';
import 'package:swag_store_app/feature/extensions.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ShopRepository _repository;

  CartBloc(this._repository) : super(CartEmptyState()) {
    on<CartEvent>((event, emit) async {
      if (event is CartInitEvent) {
        // If state was not lost - no need to reload state
        if (state is CartChangedState) {
          emit(state);
          return;
        }
        // In other case reloading state to get data from the cache
        emit(CartLoadingState());
        Order? cart = await _repository.getCart();
        if (cart != null) {
          var products = await _repository.readProducts();
          if (products.isEmpty) {
            products = await _repository.fetchProducts();
            await _repository.saveProducts(products);
          }
          Map<Product, int> selection =
              Map.from(cart.selection.toCartState(products));
          emit(CartChangedState(selection));
        } else {
          emit(CartEmptyState());
        }
      }

      if (event is CartChangeEvent) {
        var newSelection = _changeSelection(event);
        if (newSelection.isEmpty) {
          await _repository.clearCart();
          emit(CartEmptyState());
        } else {
          emit(CartChangedState(newSelection));
          Order cart = _makeAnOrder('cart');
          await _repository.saveCart(cart);
        }
      }

      if (event is CartOrderMakingEvent) {
        if (state is CartChangedState) {
          var order = _makeAnOrder(null);
          emit(CartOrderPlacingState(order));
          await _repository.clearCart();
          order = await _repository.placeOrder(order);
          emit(CartOrderedState(order));
          // pushing empty to reset state
          await Future.delayed(
            const Duration(seconds: 2),
            () => emit(CartEmptyState()),
          );
        }
      }
    });
  }

  Map<Product, int> _changeSelection(CartChangeEvent event) {
    Map<Product, int> newMap = Map.from((state as CartDataState).selection);
    if (event.count == 0) {
      newMap.remove(event.product);
      return newMap;
    }
    newMap[event.product] = event.count;
    return newMap;
  }

  Order _makeAnOrder(String? tempNumber) {
    var data = (state as CartChangedState).selection;
    var total = (state as CartChangedState).total;
    return Order(
      tempNumber: tempNumber,
      selection: data.map((key, value) => MapEntry(key.id, value)),
      totalAmount: total,
    );
  }
}
