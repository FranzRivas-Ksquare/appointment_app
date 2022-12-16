import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:appointment/models/models.dart';

class UserDB {
  Database db;

  UserDB({required this.db});

  // C in CRUD
  Future<bool> create(User user) async {
    try {
      final id = await db.insert('USERS', {
        'EMAIL': user.email,
        'NAME': user.name,
        'PASSWORD': user.password,
        'AVATAR': user.avatar,
      });

      if (kDebugMode) print('Create transaction succeed');

      return true;

    } catch(e) {
      if (kDebugMode) print('Create user error: $e');
      return false;
    }

  }

  // R in CRUD
  Future<List<User>> fetchUser(String email) async {
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
        where: 'EMAIL = ?',
        whereArgs: [email]
      );

      final useResult = read.map((row) => User.fromRow(row)).toList();
      return useResult;

    } catch(e) {
      if (kDebugMode) print('Error fetching users: $e');
      return [];
    }
  }

  // U in CRUD
  Future<bool> update(User user) async {
    try {
      final updateCount = await db.update('USERS', {
        'NAME': user.name,
        'PASSWORD': user.password,
        'AVATAR': user.avatar,
      }, where: 'EMAIL = ?', whereArgs: [user.email]);

      if (updateCount == 1) {
        if (kDebugMode) print('Update transaction succeed');
        return true;
      } else {
        if (kDebugMode) print('Update transaction failed');
        return false;
      }

    } catch(e) {
      if (kDebugMode) print('Error updating user: $e');
      return false;
    }
  }

  // D in CRUD
  Future<bool> delete(User user) async {
    try {
      final deleteCount = await db.delete(
          'USERS',
          where: 'EMAIL = ?',
          whereArgs: [user.email]);
      if (deleteCount == 1) {
        if (kDebugMode) print('Delete transaction succeed');
        return true;
      } else {
        if (kDebugMode) print('Delete transaction failed');
        return false;
      }
    } catch(e) {
      if (kDebugMode) print('Error deleting user: $e');
      return false;
    }
  }
}