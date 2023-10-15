import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:swag_store_app/domain/models/product.dart';

class Cache {
  Future<Database>? _database;
  String? _path;

  Cache() {
    init();
  }

  /// Set the path to the database. Note: Using the `join` function from the
  /// `path` package is best practice to ensure the path is correctly
  /// constructed for each platform.
  /// When the database is first created, create a table to store dogs.
  Future<bool> init() async {
    _path = _path ?? await getDatabasesPath();
    _database = _database ??
        openDatabase(
          join(_path!, 'swag_shop_data.db'),
          onCreate: (db, version) {
            // Run the CREATE TABLE for tables creations when DB is created
            return db.execute(
              'CREATE TABLE products(id INTEGER PRIMARY KEY, name TEXT, price TEXT, imageUrl TEXT, sizes TEXT, currency TEXT)',
            );
          },
          version: 1,
        );
    return true;
  }

  /// Method that saves current products into the database
  Future<void> saveProducts(List<Product> products) async {
    init().then((value) async {
      // Get a reference to the database.
      final db = await _database!;
      for (var product in products) {
        await db.insert(
          'products',
          product.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  /// A method that retrieves all the products from the table.
  Future<List<Product>> getProducts() async {
    return init().then((value) async {
      final db = await _database!;

      final List<Map<String, dynamic>> maps = await db.query('products');

      return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
    });
  }
}
