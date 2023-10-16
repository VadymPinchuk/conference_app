import 'package:swag_store_app/domain/models/product.dart';

extension TotalAmount on Map<Product, int> {
  double getTotal() => map<Product, double>(
          (product, quantity) => MapEntry(product, product.price * quantity))
      .values
      .reduce((sum, next) => sum + next);
}

extension StateFromMap on Map<int, int> {
  Map<Product, int> toCartState(List<Product> products) => map<Product, int>(
        (id, quantity) => MapEntry(
            products.firstWhere((element) => element.id == id), quantity),
      );
}
