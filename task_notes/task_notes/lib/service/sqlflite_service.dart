import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SqfLiteDatabase {
  static final _dbName = 'noteCollection.db';
  static final _dbVersion = 1;
  static final tableName = 'noteTable';
  static final columnId = 'id';
  static final columnTitle = 'title';
  static final columnDesc = 'des';

  SqfLiteDatabase._privateConstructor();
  static final SqfLiteDatabase instance = SqfLiteDatabase._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initiateDatabase();
    return _database!;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationSupportDirectory();

    String path = join(directory.path, _dbName);

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) {
    db.execute('''
        CREATE TABLE $tableName(
              $columnId INTEGER NOT NULL PRIMARY KEY,
              $columnTitle TEXT NOT NULL,
              $columnDesc TEXT 
         )
     ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  static Future<int> addNote(
      {required String title, required String des}) async {
    final row = {columnTitle: title, columnDesc: des};
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  Future<int> update(
      {required String id, required String title, required String des}) async {
    Database db = await instance.database;
    //int id = row[columnId];
    return await db.update(
        tableName,
        {
          columnTitle: title,
          columnDesc: des,
        },
        where: '$columnId = ?',
        whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
