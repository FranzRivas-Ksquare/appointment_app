import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../models/models.dart';
import '../database/database.dart';
import '../database/user_db.dart';
import '../database/appointments_db.dart';

class DataProvider extends ChangeNotifier {
  static AppDB appDB = AppDB(dbName: 'database1.db');
  String? email;
  static UserDB? userCtrl;
  static AppointmentDB? appointmentCtrl;
  User? currentUser;
  List<Appointment> appointments = [];

  DataProvider() {
    DataProvider.initDB();
  }

  @override
  void dispose() {
    DataProvider.closeDB();
    super.dispose();
  }

  //--DB services
  static void initDB() async {
    if (kDebugMode) print('Database init trigger');
    await appDB.open();
    Database db = await appDB.getDB;
    userCtrl = UserDB(db: db);
    appointmentCtrl = AppointmentDB(db: db);
  }

  static void closeDB() async {
    if (kDebugMode) print('Database close trigger');
    bool isClose = await appDB.close();
    if (isClose) {
      if (kDebugMode) print('Database is close');
    } else {
      if (kDebugMode) print('Field closing database');
    }
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
    User tempUser = await userCtrl!.fetchUser(email).then((value) => value[0]);
    if (tempUser.password == password) {
      currentUser = tempUser;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateUser(User user) async {
    bool validate = await userCtrl!.update(user);
    if (validate) {
      currentUser = user;
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

  Future<bool> updateAppointments(Appointment appointment) async {
    bool validate = await appointmentCtrl!.update(appointment);
    if (validate) {
      fetchAppointments();
      return true;
    } else {
      return false;
    }
  }

  bool availability(Appointment appointment) {
    List<Appointment> isAvailable = appointments
        .where((element) => element.date == appointment.date).toList();
    if (kDebugMode) print(appointments);
    if (kDebugMode) print(isAvailable);
    if (isAvailable == []) {
      return true;
    } else {
      return false;
    }
  }

  void deleteAppointments(int id) async {
    bool validate = await appointmentCtrl!.delete(id);
    if (validate) {
      appointments = appointments.where((element) => element.id != id).toList();
      notifyListeners();
    }
  }

  get getAppointments => appointments;
}
