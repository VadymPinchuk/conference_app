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
    this.sizes = '[single size]',
    this.currency = '£',
  }) {
    id = hashCode;
  }

  Product.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'] as String,
        price = double.tryParse(data['price'] as String) ?? 0.0,
        imageUrl = data['imageUrl'] as String,
        sizes = data['sizes'] as String,
        currency = data['currency'] as String;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'imageUrl': imageUrl,
        'currency': currency,
        'sizes': sizes.toString(),
      };

  @override
  String toString() =>
      'Product{id: $id, name: $name, price: $price, imageUrl: $imageUrl, currency: $currency, sizes: $sizes';
}
