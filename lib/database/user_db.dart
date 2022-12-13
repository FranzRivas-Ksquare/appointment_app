import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:appointment/models/models.dart';

class UserDB {
  final String dbName;
  Database? _db;
  List<User> _users = [];
  final StreamController<List<User>> _streamController = StreamController<List<User>>.broadcast();

  UserDB({required this.dbName});

  Future<List<User>> _fetchUsers() async {
    final db = _db;
    if (db == null) return [];

    try {
      final read = await db.query(
        'USERS',
        distinct: true,
        columns: [
          'ID',
          'NAME',
          'EMAIL',
          'PASSWORD',
        ],
        orderBy: 'ID',
      );

      final users = read.map((row) => User.fromRow(row)).toList();
      return users;

    } catch(e) {
      print('Error fetching users: $e');
      return [];
    }
  }

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
      const create = '''CREATE TABLE IF NOT EXISTS USERS (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME INTEGER,
        EMAIL TEXT,
        PASSWORD INTEGER,
        CONSTRAINT ID PRIMARY KEY (ID)
        );''';

      await db.execute(create);

      // Read all existing users objects from the db
      final _users = await _fetchUsers();
      _streamController.add(_users);
      return true;

    } catch(e){
      print('Error opening db = $e');
      return false;
    }

  }

  Stream<List<User>> all() => _streamController.stream.map((users) => users..sort());

}