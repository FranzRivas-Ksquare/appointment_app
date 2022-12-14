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

  // C in CRUD
  Future<bool> create(String email, String? name, String password, String? avatar) async {
    final db = _db;
    if (db == null) return false;
    
    try {
      final id = await db.insert('USERS', {
        'EMAIL': email,
        'NAME': name,
        'PASSWORD': password,
        'AVATAR': avatar,
      });

      final user = User(
        email: email,
        name: name,
        password: password,
        avatar: avatar,
      );

      _users.add(user);
      _streamController.add(_users);

      return true;

    } catch(e) {
      print('Create user error: $e');
      return false;
    }

  }

  // R in CRUD
  Future<List<User>> _fetchUsers() async {
    final db = _db;
    if (db == null) return [];

    try {
      final read = await db.query(
        'USERS',
        distinct: true,
        columns: [
          'EMAIL',
          'NAME',
          'PASSWORD',
          'AVATAR'
        ],
        orderBy: 'NAME',
      );

      final users = read.map((row) => User.fromRow(row)).toList();
      return users;

    } catch(e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  // U in CRUD
  Future<bool> update(User user) async {
    final db = _db;
    if (db == null) return false;

    try {

      final updateCount = await db.update('USERS', {
        'NAME': user.name,
        'PASSWORD': user.password,
        'AVATAR': user.avatar,
      }, where: 'EMAIL = ?', whereArgs: [user.email]);

      if (updateCount == 1) {
        _users.removeWhere((other) => other.email == user.email);
        _users.add(user);
        _streamController.add(_users);
        return true;
      } else {
        return false;
      }

    } catch(e) {
      print('Error updating user: $e');
      return false;
    }
  }

  // D in CRUD
  Future<bool> delete(User user) async {
    final db = _db;
    if (db == null) return false;

    try {
      final deleteCount = await db.delete(
          'USERS',
          where: 'EMAIL = ?',
          whereArgs: [user.email]);
      if (deleteCount == 1) {
        _users.remove(user);
        _streamController.add(_users);
        return true;
      } else {
        return false;
      }
    } catch(e) {
      print('Error deleting user: $e');
      return false;
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
          EMAIL TEXT,
          NAME TEXT,
          PASSWORD TEXT,
          AVATAR TEXT,
          CONSTRAINT USERS_PK PRIMARY KEY (EMAIL)
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