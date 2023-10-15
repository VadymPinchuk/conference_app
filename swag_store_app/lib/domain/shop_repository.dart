import 'package:swag_store_app/data/mock_api.dart';
import 'package:swag_store_app/data/mock_cache.dart';
import 'package:swag_store_app/domain/models/order.dart';
import 'package:swag_store_app/domain/models/product.dart';

class ShopRepository {
  late final MockApi _api;
  late final Cache _cache;

  ShopRepository(this._api, this._cache);

  Future<void> init() async => _cache.init();

  Future<List<Product>> fetchProducts() async => _api.fetchProducts();

  Future<List<Product>> readProducts() async => _cache.getProducts();

  Future<void> saveProducts(List<Product> products) async =>
      _cache.saveProducts(products);

  Future<Order> placeOrder(Order newOrder) async => _api.placeOrder(newOrder);

  Future<List<Order>> fetchOrders() async => _api.fetchOrders();
}
