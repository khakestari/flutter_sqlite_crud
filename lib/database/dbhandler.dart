import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'dart:async';

import '../model/product.dart';

class DBHandler {
  Database? _db;

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'products.db');
    var db = await openDatabase(path, version: 1, onCreate: onCreate);
    return db;
  }

  void onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS products(name TEXT not null, description TEXT not null, price DOUBLE not null)');
  }

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    }
    return _db;
  }

  // Create Data
  Future<int> createP(Product product) async {
    var dbReady = await db;
    return await dbReady!.rawInsert(
        "INSERT INTO products(name, description, price) VALUES ('${product.name}', '${product.description}', '${product.price}')");
  }

  // Read Data
  Future<Product> readP(String name) async {
    var dbReady = await db;
    var read =
        await dbReady!.rawQuery("SELECT * FROM products WHERE name = '$name'");
    return Product(
      read[0]['name'].toString(),
      read[0]['description'].toString(),
      double.parse(read[0]['price'].toString()),
    );
  }

  // Update Data
  Future<int> updateP(Product product) async {
    var dbReady = await db;
    return await dbReady!.rawInsert(
        "UPDATE products SET description = '${product.description}', price = '${product.price}' WHERE name = '${product.name}'");
  }

  // Delete Data
  Future<int> deleteP(String name) async {
    var dbReady = await db;
    return await dbReady!
        .rawInsert("DELETE FROM products WHERE name = '$name'");
  }

  //
}
