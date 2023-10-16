import 'dart:convert';

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

  /// Converters toJson and fromJson
  factory Order.fromJson(Map<String, dynamic> json) => Order(
        selection: Order._mapFromJson(json['selection'] as String),
        totalAmount: double.tryParse(json['totalAmount'] as String) ?? 0.0,
      )
        ..number = json['number'] as String
        ..date = DateTime.parse(json['date'] as String);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'number': number,
        'date': date.toIso8601String(),
        'selection': Order._mapToJson(selection),
        'totalAmount': totalAmount.toString(),
      };

  /// TODO: rewrite this encoding and decoding
  /// Map specific converters to Json and from Json
  static String _mapToJson(Map<int, int> selection) => selection.toString();

  static Map<int, int> _mapFromJson(String json) => jsonDecode(json).map(
        (key, value) => MapEntry(int.tryParse(key), int.tryParse(value)),
      );

  /// Additional methods for future work
  Order copyWithNewNumber() =>
      Order(selection: selection, totalAmount: totalAmount);

  DateTime _getDate() => DateTime.now();

  String _getNumber(DateTime now) =>
      '${DateFormat.jms().format(now)}_${DateFormat.yMd().format(now)}';
}
