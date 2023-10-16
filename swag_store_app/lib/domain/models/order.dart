import 'package:intl/intl.dart';

class Order {
  late final String number;
  late final DateTime date;
  final Map<int, int> selection;
  late final double totalAmount;

  Order({
    String? tempNumber,
    required this.selection,
    required this.totalAmount,
  }) {
    var now = _getDate();
    number = tempNumber ?? _getNumber(now);
    date = now;
  }

  Order._({
    required this.number,
    required this.selection,
    required this.totalAmount,
    required this.date,
  });

  /// Additional methods for future work
  Order copyWithNewNumber() =>
      Order(selection: selection, totalAmount: totalAmount);

  DateTime _getDate() => DateTime.now();

  String _getNumber(DateTime now) =>
      '${DateFormat.jms().format(now)}_${DateFormat.yMd().format(now)}';
}

/// Order parsing specific extensions
extension JsonToOrder on Map<String, dynamic> {
  Order toOrder() => Order._(
        number: this['number'] as String,
        selection: (this['selection'] as String).asMap(),
        totalAmount: double.tryParse(this['totalAmount'] as String) ?? 0.0,
        date: DateTime.parse(this['date'] as String),
      );
}

extension OrderToJson on Order {
  Map<String, dynamic> toJson() => <String, dynamic>{
        'number': number,
        'date': date.toIso8601String(),
        'selection': selection.asString(),
        'totalAmount': totalAmount.toString(),
      };
}

/// Selection Map<int, int> specific extensions
extension StringAsMap on String {
  Map<int, int> asMap() => {}..addEntries(
      split('-').where((element) => element.isNotEmpty).map<MapEntry<int, int>>(
        (pair) {
          var numbers = pair.trim().split(':');
          return MapEntry(int.parse(numbers[0]), int.parse(numbers[1]));
        },
      ),
    );
}

extension MapAsString on Map<int, int> {
  String asString() => entries.fold(
      '-', (prev, element) => '$prev${element.key}:${element.value}-');
}
