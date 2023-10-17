
class Product {
  late final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String currency;
  final String sizes;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.currency = '£',
    this.sizes = '[single size]',
  }) : id = imageUrl.hashCode;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json['name'] as String,
        price: double.tryParse(json['price'] as String) ?? 0.0,
        imageUrl: json['imageUrl'] as String,
        currency: json['currency'] as String? ?? '£',
        sizes: json['sizes'] as String? ?? '[single size]',
      );

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'price': price.toString(),
        'imageUrl': imageUrl,
        'currency': currency,
        'sizes': sizes,
      };

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    return hashCode == other.hashCode;
  }

}
