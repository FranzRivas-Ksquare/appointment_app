import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:appointment/models/models.dart';
import 'package:appointment/database/database.dart';
import 'package:appointment/database/user_db.dart';
import 'package:appointment/database/appointments_db.dart';


class DataProvider extends ChangeNotifier {
  AppDB appDB = AppDB(dbName: 'db.sqlite');
  User user;
  List<Appointment> appointments = [];

  DataProvider({required this.user});

  void initDB() async {
    appDB.open();
    Database db = appDB.getDB;
    UserDB userDB = UserDB(db: db);
    AppointmentDB appointmentDB = AppointmentDB(db: db, user: user);
    appointments = await fetchAppointments(appointmentDB);
    notifyListeners();
  }

  Future<List<Appointment>> fetchAppointments(AppointmentDB appointments) {
    return appointments.fetchAppointments();
  }

}