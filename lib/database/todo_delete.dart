import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/models.dart';

class DBHelper {
  static Database? _db;

  Future<Database> init() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'appsDB6.db'),
      version: 1,
    );
  }

  void createTables() async {
    var db = await init();
    createUsersTable(db);
    createAppsTable(db);
  }

  void createAppsTable(db) async {
    db
        .execute(
            'CREATE TABLE IF NOT EXISTS appointments (id	INTEGER NOT NULL UNIQUE,title	TEXT NOT NULL,date	TEXT DEFAULT CURRENT_TIMESTAMP,description	TEXT,userEmail	TEXT NOT NULL,FOREIGN KEY(userEmail) REFERENCES users(email),PRIMARY KEY(id))')
        .then((res) {
      print("CREATED APPOINTMENTS TABLE");
    }).catchError((e) {
      print(e);
    });
  }

  void createUsersTable(db) async {
    db
        .execute(
            'CREATE TABLE IF NOT EXISTS users (name	TEXT NOT NULL,email	TEXT NOT NULL UNIQUE,password	TEXT NOT NULL,PRIMARY KEY(email))')
        .then((res) {
      print("CREATED USERS TABLE");
    }).catchError((e) {
      print(e);
    });
  }

  void insertAppsData(Appointment app) async {
    var db = await init();
    await db.insert(
      'appointments',
      app.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void insertUsersData(User user) async {
    var db = await init();
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void deleteAppsData(int id) async {
    var db = await init();
    await db.delete('appointments', where: '"id"=$id');
  }

  void deleteUsersData(String email) async {
    var db = await init();
    await db.delete('users', where: 'email=$email');
  }

  void updateAppsData(Appointment app) async {
    var db = await init();
    await db.update('appointments', app.toMap(),
        where: 'id=?', whereArgs: [app.id]);
  }

  void updateUsersData(User user) async {
    var db = await init();
    await db.update('users', user.toMap(),
        where: 'email=?', whereArgs: [user.email]);
  }

  Future<List<Appointment>> returnAppsData() async {
    var db = await init();
    final List<Map<String, dynamic>> maps =
        await db.query('appointments', where: '"userEmail"="pp@gmail.com"');
    print(maps.runtimeType);
    var data = List.generate(
        maps.length,
        (index) => Appointment(
            id: maps[index]['id'],
            title: maps[index]['title'],
            description: maps[index]['description'],
            date: maps[index]['date'],
            author: maps[index]['userEmail']));
    return data;
  }

  Future<List<User>> returnUsersData() async {
    var db = await init();
    final List<Map<String, dynamic>> maps =
        await db.query('users', where: '"email"="jj@hotmail.com"');
    print(maps.runtimeType);
    print(maps.length);
    var data = List.generate(
        maps.length,
        (index) => User(
            name: maps[index]['name'],
            email: maps[index]['email'],
            password: maps[index]['password']));
    return data;
  }
}
