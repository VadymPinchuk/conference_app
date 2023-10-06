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
      if (event is CartChangeEvent) {
        emit(CartChangedState(_changeSelection(event)));
      }

      if (event is CartOrderMakingEvent) {
        if (state is CartChangedState) {
          var order = _makeAnOrder();
          emit(CartOrderPlacingState(order));
          order = await _repository.placeOrder(order);
          emit(CartOrderedState(order));
        }
      }

      if (event is CartOrderedEvent) {
        emit(CartEmptyState());
      }
    });
  }

  Map<Product, int> _changeSelection(CartChangeEvent event) {
    Map<Product, int> newMap = Map.from((state as CartMapState).selection);
    newMap[event.product] = event.count;
    return newMap;
  }

  Order _makeAnOrder() {
    var data = (state as CartChangedState).selection;
    var total = (state as CartChangedState).total;
    return Order(products: data, totalAmount: total);
  }
}
