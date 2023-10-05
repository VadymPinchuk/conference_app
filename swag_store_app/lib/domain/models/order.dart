import 'package:swag_store_app/domain/models/product.dart';
import 'package:intl/intl.dart';

class Order {
  late final String number;
  late final DateTime date;
  final List<Product> products;

  Order({
    required this.products,
  }) {
    var now = _getDate();
    number = _getNumber(now);
    date = now;
  }

  Order copyWithNewNumber() => Order(products: products);

  DateTime _getDate() => DateTime.now();

  String _getNumber(DateTime now) =>
      '${DateFormat.jms().format(now)}_${DateFormat.yMd().format(now)}';
}
