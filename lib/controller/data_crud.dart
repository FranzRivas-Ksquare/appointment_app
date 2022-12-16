import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:appointment/models/models.dart';
import 'package:appointment/database/database.dart';
import 'package:appointment/database/user_db.dart';
import 'package:appointment/database/appointments_db.dart';


class DataProvider extends ChangeNotifier {
  AppDB appDB = AppDB(dbName: 'db.sqlite');
  String? email;
  List<Appointment> appointments = [];

  void initDB(String email) async {
    appDB.open();
    Database db = appDB.getDB;
    UserDB userDB = UserDB(db: db);
    User user = await fetchUsers(userDB, email).then((value) => value[0]);
    AppointmentDB appointmentDB = AppointmentDB(db: db, user: user);
    appointments = await fetchAppointments(appointmentDB);
    notifyListeners();
  }

  Future<List<Appointment>> fetchAppointments(AppointmentDB appointmentsDB) {
    return appointmentsDB.fetchAppointments();
  }

  Future<List<User>> fetchUsers(UserDB usersDB, String email) {
    return usersDB.fetchUser(email);
  }

}