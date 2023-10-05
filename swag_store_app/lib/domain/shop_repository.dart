import 'package:swag_store_app/data/mock_api.dart';
import 'package:swag_store_app/domain/models/order.dart';
import 'package:swag_store_app/domain/models/product.dart';

class ShopRepository {
  late final MockApi _api;

  ShopRepository(this._api);

  Future<List<Product>> fetchProducts() async => _api.fetchProducts();

  Future<Order> placeOrder(Order newOrder) async => _api.placeOrder(newOrder);

  Future<List<Order>> fetchOrders() async => _api.fetchOrders();
}
