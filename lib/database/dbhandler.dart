import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

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
        'CREATE TABLE Products(name TEXT, description TEXT, price DOUBLE)');
  }

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    }
    return _db;
  }
}
