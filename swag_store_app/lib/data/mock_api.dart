import 'dart:async';

import 'package:swag_store_app/domain/models/order.dart';
import 'package:swag_store_app/domain/models/product.dart';

class MockApi {
  final List<Product> _products = [
    Product(
        name: 'Stickers set',
        price: 1.99,
        imageUrl:
            'https://ih1.redbubble.net/image.4688491751.5764/st,small,507x507-pad,600x600,f8f8f8.u11.jpg'),
    Product(
        name: 'Sticker Logo original',
        price: 0.99,
        imageUrl:
            'https://ih1.redbubble.net/image.649468612.4277/st,small,507x507-pad,600x600,f8f8f8.u3.jpg'),
    Product(
        name: 'Notebook',
        price: 3.99,
        imageUrl:
            'https://ih1.redbubble.net/image.3694795880.8037/gbrf,5x7,f,540x540-pad,450x450,f8f8f8.jpg'),
    Product(
        name: 'T-shirt Dark W',
        price: 20,
        imageUrl:
            'https://ih1.redbubble.net/image.5178868346.9928/ssrco,classic_tee,womens,101010:01c5ca27c6,front_alt,square_product,600x600.jpg',
        sizes: ['XXS', 'XS', 'S', 'M', 'L']),
    Product(
        name: 'Sticker Logo gray scale',
        price: 0.99,
        imageUrl:
            'https://ih1.redbubble.net/image.1558685385.3764/st,small,507x507-pad,600x600,f8f8f8.jpg'),
    Product(
        name: 'Strange stickers set',
        price: 5.99,
        imageUrl:
            'https://ih1.redbubble.net/image.1097144531.6498/st,small,507x507-pad,600x600,f8f8f8.u2.jpg'),
    Product(
        name: 'T-shirt Light W',
        price: 20,
        imageUrl:
            'https://ih1.redbubble.net/image.3265868284.0051/ssrco,classic_tee,womens,fafafa:ca443f4786,front_alt,square_product,600x600.jpg',
        sizes: ['XXS', 'XS', 'S', 'M', 'L']),
    Product(
        name: 'iPhone case',
        price: 25.99,
        imageUrl:
            'https://ih1.redbubble.net/image.5080901605.8050/icr,iphone_14_tough,back,a,x600-pad,600x600,f8f8f8.jpg'),
    Product(
        name: 'T-shirt Dark M',
        price: 20,
        imageUrl:
            'https://ih1.redbubble.net/image.1558727679.4665/ssrco,classic_tee,mens,101010:01c5ca27c6,front_alt,square_product,600x600.jpg',
        sizes: ['S', 'M', 'L', 'XL', 'XXL', 'XXXL']),
    Product(
        name: 'T-shirt Light M',
        price: 20,
        imageUrl:
            'https://ih1.redbubble.net/image.3265919409.1384/ssrco,classic_tee,mens,fafafa:ca443f4786,front_alt,square_product,600x600.jpg',
        sizes: ['S', 'M', 'L', 'XL', 'XXL', 'XXXL']),
    Product(
        name: 'Dash fluff toy',
        price: 333.99,
        imageUrl:
            'https://ih1.redbubble.net/image.4798260528.8053/st,small,507x507-pad,600x600,f8f8f8.jpg'),
    Product(
        name: 'BackPack Light',
        price: 49,
        imageUrl:
            'https://ih1.redbubble.net/image.3735703887.7858/ur,backpack_front,square,600x600.jpg'),
    Product(
        name: 'BackPack Original',
        price: 49,
        imageUrl:
            'https://ih1.redbubble.net/image.3694795992.8037/ur,backpack_front,square,600x600.jpg'),
    Product(
        name: 'Flutter Wall Clock',
        price: 33.99,
        imageUrl:
            'https://ih1.redbubble.net/image.1962523415.8520/clkf,bamboo,white,600x600-bg,f8f8f8.jpg'),
    Product(
        name: 'Flutter Hat',
        price: 13.99,
        imageUrl:
            'https://ih1.redbubble.net/image.5208913014.7777/ssrco,baseball_cap,product,161D36:1628f0f39d,front,square,600x600-bg,f8f8f8.jpg'),
    Product(
        name: 'Big sticker',
        price: 3.99,
        imageUrl:
            'https://ih1.redbubble.net/image.3694737291.6610/st,small,507x507-pad,600x600,f8f8f8.jpg'),
    Product(
        name: 'Hex sticker',
        price: 1.99,
        imageUrl:
            'https://ih1.redbubble.net/image.1010802811.1077/st,small,507x507-pad,600x600,f8f8f8.u2.jpg'),
    Product(
        name: 'BackPack Dark',
        price: 49,
        imageUrl:
            'https://ih1.redbubble.net/image.3735736620.8674/ur,backpack_front,square,600x600.jpg'),
    Product(
        name: 'Sash Sticker',
        price: 2.99,
        imageUrl:
            'https://ih1.redbubble.net/image.3433260968.7459/st,small,507x507-pad,600x600,f8f8f8.jpg'),
  ];

  final List<Order> _orders = List.empty(growable: true);

  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    return _products;
  }

  Future<Order> placeOrder(Order newOrder) async {
    var savedOrder = newOrder.copyWithNewNumber();
    _orders.add(savedOrder);
    await Future.delayed(const Duration(seconds: 2));
    return savedOrder;
  }

  Future<List<Order>> fetchOrders() async {
    await Future.delayed(const Duration(seconds: 2));
    return _orders;
  }
}
