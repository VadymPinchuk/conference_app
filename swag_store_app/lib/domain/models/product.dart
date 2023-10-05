class Product {
  late final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String currency;
  final List<String> sizes;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.sizes = const ['single size'],
    this.currency = '£',
  }) {
    id = hashCode.toString();
  }
}
