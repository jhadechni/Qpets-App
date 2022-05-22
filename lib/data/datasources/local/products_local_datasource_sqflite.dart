import 'dart:async';
import 'package:path/path.dart';
import 'package:qpets_app/domain/entities/product.dart';
import 'package:sqflite/sqflite.dart';

class ProductLocalDataSource {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'product_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE product (id TEXT PRIMARY KEY, image TEXT, name TEXT,storeName TEXT, price TEXT, type TEXT, description TEXT, facebook TEXT, instagram TEXT, phoneNumber TEXT)');
  }

  Future<void> addAllProducts(List<Product> products) async {
    final db = await database;
    // aquí se debe llamar al db.insert
    // ignore: avoid_function_literals_in_foreach_calls
    await Future.forEach(products, (Product element) async {
      await db.insert(
        'product',
        element.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<void> addProduct(Product product) async {
    final db = await database;
    await db.insert(
      'product',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Product>> getAllProducts() async {
    final db = await database;

    final List<Map<String, dynamic>> products = await db.query('product');
    print("GetALl");
    print(products);
    return List.generate(products.length, (i) {
      //keep in mind the index
      return Product(
        id: products[i]['id'],
        image: products[i]['image'] ?? "",
        name: products[i]['name'],
        storeName: products[i]['storeName'],
        price: products[i]['price'],
        type: products[i]['type'],
        description: products[i]['description'],
        facebook: products[i]['facebook'],
        instagram: products[i]['instagram'],
        phoneNumber: products[i]['phoneNumber'],
        ownerId: products[i]['ownerId']
      );
    });
  }

  Future<void> deleteAll() async {
    Database db = await database;
    await db.delete('product');
  }
}
