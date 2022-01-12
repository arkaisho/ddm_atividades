import 'package:ddm_atividade_2/item.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Data {
  Future<Database> database() async {
    WidgetsFlutterBinding.ensureInitialized();

    return await openDatabase(
      join(
        await getDatabasesPath(),
        'doggie_database.db',
      ),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE items(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
        );
      },
    );
  }

  Future<int> getNextId() async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query('items');

    List<Item> items = List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
      );
    });

    int biggerId = 0;
    for (var item in items) {
      if (item.id > biggerId) biggerId = item.id;
    }

    return biggerId + 1;
  }

  Future<List<Item>> items() async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query('items');

    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
      );
    });
  }

  Future<void> insertItem(Item item) async {
    final db = await database();
    await db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateItem(Item item) async {
    final db = await database();

    await db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> deleteItem(int id) async {
    final db = await database();

    await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
