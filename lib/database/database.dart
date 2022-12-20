import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class AppDB {
  final String dbName;
  Database? _db;

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
        ID INTEGER NOT NULL UNIQUE,
        TITLE TEXT NOT NULL,DESCRIPTION TEXT,
        DATE TEXT NOT NULL,
        AUTHOR TEXT NOT NULL,
        CONSTRAINT APPOINTMENTS_FK FOREIGN KEY (AUTHOR) REFERENCES USERS(EMAIL),
        PRIMARY KEY(id)       
      )''';

      const tableUser = '''CREATE TABLE IF NOT EXISTS USERS (
        EMAIL	TEXT NOT NULL UNIQUE,
        PASSWORD TEXT NOT NULL,
        NAME TEXT NOT NULL,
        AVATAR TEXT,
        CONSTRAINT USERS_PK PRIMARY KEY (EMAIL)
      )''';

      await db.execute(tableAppoint);
      if (kDebugMode) print("APPOINTMENTS TABLE CREATED");
      await db.execute(tableUser);
      if (kDebugMode) print("USERS TABLE CREATED");

      if (kDebugMode) print("DATABASE $dbName CREATED");
      return true;
    } catch (e) {
      if (kDebugMode) print('Error opening database: $e');
      return false;
    }
  }

  Future<Database> get getDB async {
    if (_db == null) final createDB = await open();
    Database db = _db!;
    return db;
  }
}
