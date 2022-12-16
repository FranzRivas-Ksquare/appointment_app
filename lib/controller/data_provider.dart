import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:appointment/models/models.dart';
import 'package:appointment/database/database.dart';
import 'package:appointment/database/user_db.dart';
import 'package:appointment/database/appointments_db.dart';


class DataProvider extends ChangeNotifier {
  AppDB appDB = AppDB(dbName: 'db.sqlite');
  String? email;
  UserDB? userCtrl;
  AppointmentDB? appointmentCtrl;
  User? currentUser;
  List<Appointment> appointments = [];

  DataProvider();
  DataProvider.initDB();

  void initDB() async {
    appDB.open();
    Database db = await appDB.getDB;
    UserDB userDB = UserDB(db: db);
    AppointmentDB appointmentDB = AppointmentDB(db: db);
    userCtrl = userDB;
    appointmentCtrl = appointmentDB;
  }

  void signUpUser(User user) async {
    bool validate = await userCtrl!.create(user);
    if (validate) {
      currentUser = user;
      notifyListeners();
    }
  }

  Future<bool> signInUSer(String email, String password) async {
    List<User> tempUser = await userCtrl!.fetchUser(email);
    if (tempUser[0].password == password) {
      currentUser = tempUser[0];
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void fetchAppointments() async {
    appointments = await appointmentCtrl!.fetchAppointments(currentUser!);
    notifyListeners();
  }

  void createAppointments(Appointment appointment) async {
    bool validate = await appointmentCtrl!.create(appointment);
    if (validate) {
      appointments.add(appointment);
      notifyListeners();
    }
  }

  void updateAppointments(Appointment appointment) {
    appointmentCtrl!.update(appointment);
    fetchAppointments();
    notifyListeners();
  }

  void deleteAppointments(Appointment appointment) async {
    bool validate = await appointmentCtrl!.delete(appointment);
    if (validate) {
      appointments = appointments.where((element) => element.id != appointment.id).toList();
    }
    notifyListeners();
  }

}