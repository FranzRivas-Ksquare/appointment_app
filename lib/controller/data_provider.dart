import 'package:appointment/resources/dateTime_manager.dart';
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
  List<Appointment> _appointments = [];
  List<Appointment> _filter = [];

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

  Future<bool> signInUser(String email, String password) async {
    User? tempUser = await userCtrl!.fetchUser(email);
    if (tempUser == null) {
      return false;
    }
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
    _appointments = await appointmentCtrl!.fetchAppointments(currentUser!);
    _filter = [];
    _filter.addAll(_appointments);
    notifyListeners();
  }

  Future<bool> createAppointments(Appointment appointment) async {
    bool validate = await appointmentCtrl!.create(appointment);
    if (validate) {
      _appointments.add(appointment);
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
    List<Appointment> isAvailable = _appointments
        .where((element) => element.date == appointment.date)
        .toList();
    if (kDebugMode) print(_appointments);
    if (kDebugMode) print(isAvailable);
    return isAvailable.isEmpty;
  }

  void deleteAppointments(int id) async {
    bool validate = await appointmentCtrl!.delete(id);
    if (validate) {
      fetchAppointments();
      notifyListeners();
    }
  }

  get getAppointments => _filter;

  //--Filter
  void timeRatioAll() {
    _filter = _appointments
        .where((element) => DatetimeManager()
        .compareNotPastDates(element.date)).toList();
    notifyListeners();
  }

  void timeRatioToday() {
    _filter = _appointments
        .where((element) => element.date.day == DateTime.now().day).toList();
    notifyListeners();
  }

  void timeRatioTomorrow() {
    _filter = _appointments
        .where((element) => element.date.day == DateTime.now().day + 1).toList();
    notifyListeners();
  }

  void timeRatioPast() {
    _filter = _appointments
        .where((element) => DatetimeManager()
        .comparePastDates(element.date)).toList();
    notifyListeners();
  }

  void selectRatio(int index) {
    switch (index) {
      case 1:
        timeRatioToday();
        break;
      case 2:
        timeRatioTomorrow();
        break;
      case 3:
        timeRatioPast();
        break;
      default:
        timeRatioAll();
        break;
    }
  }
}
