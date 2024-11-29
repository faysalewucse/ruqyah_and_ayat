import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();

  factory DBHelper() => _instance;

  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favorite_ids.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE favorite_ids (
            id INTEGER PRIMARY KEY
          )
        ''');
      },
    );
  }

  // Insert ID into the database
  Future<int> insertId(int id) async {
    final db = await database;
    return await db.insert('favorite_ids', {'id': id});
  }

  // Delete ID from the database
  Future<int> deleteId(int id) async {
    final db = await database;
    return await db.delete('favorite_ids', where: 'id = ?', whereArgs: [id]);
  }

  // Fetch all IDs
  Future<List<int>> getAllIds() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('favorite_ids');
    return result.map((map) => map['id'] as int).toList();
  }

  // Check if an ID exists
  Future<bool> isFavorite(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> result =
    await db.query('favorite_ids', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }
}
