import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class AppDB {
  final String dbName;
  Database? _db; // TODO: Check _db return same as db

  AppDB({required this.dbName});

  Future<bool> close() async {
    final db = _db;
    if (db == null) return false;

    await db.close();
    return true;
  }

  Future<bool> open() async {
    if (_db != null) return true;

    final databasesPath = await getApplicationDocumentsDirectory();
    String path = '$databasesPath/$dbName';

    try {
      final db = await openDatabase(path);
      _db = db;

      // Create Table
      const tableAppoint = '''CREATE TABLE IF NOT EXISTS APPOINTMENTS (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        TITLE TEXT NOT NULL,
        DESCRIPTION TEXT,
        DATE TEXT NOT NULL,
        AUTHOR TEXT NOT NULL,
        CONSTRAINT APPOINTMENTS_FK FOREIGN KEY (AUTHOR) REFERENCES USERS(EMAIL),       
        );''';

      const tableUser = '''CREATE TABLE IF NOT EXISTS USERS (
        EMAIL	TEXT NOT NULL UNIQUE,
        PASSWORD TEXT NOT NULL,
        NAME TEXT,
        CONSTRAINT USERS_PK PRIMARY KEY (EMAIL),
      );''';

      await db.execute(tableAppoint);
      await db.execute(tableUser);

      return true;
    } catch (e) {
      if (kDebugMode) print('Error opening database: $e');
      return false;
    }
  }

  Future<Database?> get getDB async {
    try{
      if (_db == null) final createDB = await open();
      return _db;
    } catch(e) {
      if (kDebugMode) print('Error getting database: $e');
      return null;
    }
  }
}