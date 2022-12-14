import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:appointment/models/models.dart';

class AppointmentDB {
  final String dbName;
  Database? _db;
  List<Appointment> _appointments = [];
  final _streamController = StreamController<List<Appointment>>.broadcast();

  AppointmentDB({required this.dbName});

  // C in CRUD
  Future<bool> create(
      String title, String? description, String date, String email) async {
    final db = _db;
    if (db == null) return false;

    try {
      final id = await db.insert('APPOINTMENTS', {
        'TITLE': title,
        'DESCRIPTION': description,
        'DATE': date,
        'EMAIL': email,
      });

      final appointment = Appointment(
        title: title,
        description: description,
        date: date,
        email: email,
      );

      _appointments.add(appointment);
      _streamController.add(_appointments);

      return true;

    } catch(e) {
      print('Error creating appointment: $e');
      return false;
    }

  }

  // R in CRUD
  Future<List<Appointment>> _fetchAppointments() async {
    final db = _db;
    if (db == null) return [];

    try {
      final read = await db.query(
        'APPOINTMENTS',
        distinct: true,
        columns: [
          'ID',
          'TITLE',
          'DESCRIPTION',
          'DATE',
          'EMAIL'
        ],
        orderBy: 'DATE',
      );

      final appointment = read.map((row) => Appointment.fromRow(row)).toList();
      return appointment;

    } catch(e) {
      print('Error fetching appointments: $e');
      return [];
    }
  }

  // U in CRUD
  Future<bool> update(Appointment appointment) async {
    final db = _db;
    if (db == null) return false;

    try {

      final updateCount = await db.update('APPOINTMENTS', {
        'TITLE': appointment.title,
        'DESCRIPTION': appointment.description,
        'DATE': appointment.date,
        'EMAIL': appointment.email,
      }, where: 'ID = ?', whereArgs: [appointment.id]);

      if (updateCount == 1) {
        _appointments.removeWhere((other) => other.id == appointment.id);
        _appointments.add(appointment);
        _streamController.add(_appointments);
        return true;
      } else {
        return false;
      }

    } catch(e) {
      print('Error updating appointment: $e');
      return false;
    }
  }

  // D in CRUD
  Future<bool> delete(Appointment appointment) async {
    final db = _db;
    if (db == null) return false;

    try {
      final deleteCount = await db.delete(
          'APPOINTMENTS',
          where: 'ID = ?',
          whereArgs: [appointment.id]);
      if (deleteCount == 1) {
        _appointments.remove(appointment);
        _streamController.add(_appointments);
        return true;
      } else {
        return false;
      }
    } catch(e) {
      print('Error deleting appointment: $e');
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
      const create = '''CREATE TABLE IF NOT EXISTS APPOINTMENTS (
        TITLE TEXT,
        DESCRIPTION TEXT,
        DATE TEXT,
        EMAIL TEXT,
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        CONSTRAINT APPOINTMENT_PK PRIMARY KEY (ID),
        CONSTRAINT APPOINTMENT_FK FOREIGN KEY (EMAIL) REFERENCES USERS(EMAIL)
        );''';

      await db.execute(create);

      // Read all existing users objects from the db
      final _appointment = await _fetchAppointments();
      _streamController.add(_appointment);
      return true;

    } catch(e){
      print('Error opening db = $e');
      return false;
    }

  }

  Stream<List<Appointment>> all() => _streamController.stream.map((appointments) => appointments..sort());

}