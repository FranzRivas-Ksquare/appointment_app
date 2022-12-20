import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../models/models.dart';
import '../database/database.dart';
import '../database/user_db.dart';
import '../database/appointments_db.dart';

class DataProvider extends ChangeNotifier {
  static AppDB appDB = AppDB(dbName: 'database.db');
  String? email;
  static UserDB? userCtrl;
  static AppointmentDB? appointmentCtrl;
  User? currentUser;
  List<Appointment> appointments = [];

  DataProvider() {
    DataProvider.initDB();
  }

  //--DB init service
  static void initDB() async {
    if (kDebugMode) print("Database init trigger");
    await appDB.open();
    Database db = await appDB.getDB;
    UserDB userDB = UserDB(db: db);
    AppointmentDB appointmentDB = AppointmentDB(db: db);
    userCtrl = userDB;
    appointmentCtrl = appointmentDB;
  }

  //--User services
  Future<bool> signUpUser(User user) async {
    bool validate = await userCtrl!.create(user);
    if (validate) {
      currentUser = user;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  // TODO: "Error no match user = Array range error" Fix this!!!
  Future<bool> signInUser(String email, String password) async {
    User tempUser = await userCtrl!
        .fetchUser(email)
        .then((value) => value[0]);
    if (tempUser.password == password) {
      currentUser = tempUser;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  get getCurrentUser => currentUser;

  //--Appointments services
  void fetchAppointments() async {
    appointments = await appointmentCtrl!.fetchAppointments(currentUser!);
    notifyListeners();
  }

  Future<bool> createAppointments(Appointment appointment) async {
    bool validate = await appointmentCtrl!.create(appointment);
    if (validate) {
      appointments.add(appointment);
      notifyListeners();
      return true;
    } else {
      return false;
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
      appointments = appointments
          .where((element) => element.id != appointment.id)
          .toList();
    }
    notifyListeners();
  }

  get getAppointments => appointments;
}
