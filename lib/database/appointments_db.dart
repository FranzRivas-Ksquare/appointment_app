import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:appointment/models/models.dart';

class AppointmentDB {
  Database db;

  AppointmentDB({required this.db});

  // C in CRUD
  Future<bool> create(Appointment appointment) async {
    try {
      final id = await db.insert('APPOINTMENTS', {
        'TITLE': appointment.title,
        'DESCRIPTION': appointment.description,
        'DATE': appointment.date,
        'AUTHOR': appointment.author,
      });

      if (kDebugMode) print('Create transaction succeed');

      return true;
    } catch (e) {
      if (kDebugMode) print('Error creating appointment: $e');
      return false;
    }
  }

  // R in CRUD
  Future<List<Appointment>> fetchAppointments(User user) async {
    try {
      final read = await db.query('APPOINTMENTS',
          distinct: true,
          columns: ['ID', 'TITLE', 'DESCRIPTION', 'DATE', 'AUTHOR'],
          orderBy: 'DATE',
          where: 'AUTHOR = ?',
          whereArgs: [user.email]);

      final appointments = read.map((row) => Appointment.fromRow(row)).toList();
      return appointments;
    } catch (e) {
      if (kDebugMode) print('Error fetching appointments: $e');
      return [];
    }
  }

  // U in CRUD
  Future<bool> update(Appointment appointment) async {
    try {
      final updateCount = await db.update(
          'APPOINTMENTS',
          {
            'TITLE': appointment.title,
            'DESCRIPTION': appointment.description,
            'DATE': appointment.date,
            'AUTHOR': appointment.author,
          },
          where: 'ID = ?',
          whereArgs: [appointment.id]);

      if (updateCount == 1) {
        if (kDebugMode) print('Update transaction succeed');
        return true;
      } else {
        if (kDebugMode) print('Update transaction failed');
        return false;
      }
    } catch (e) {
      if (kDebugMode) print('Error updating appointment: $e');
      return false;
    }
  }

  // D in CRUD
  Future<bool> delete(int id) async {
    try {
      final deleteCount =
          await db.delete('APPOINTMENTS', where: 'ID = ?', whereArgs: [id]);
      if (deleteCount == 1) {
        if (kDebugMode) print('Delete transaction succeed');
        return true;
      } else {
        if (kDebugMode) print('Delete transaction failed');
        return false;
      }
    } catch (e) {
      if (kDebugMode) print('Error deleting appointment: $e');
      return false;
    }
  }
}
