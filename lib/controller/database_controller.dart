import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../resources/dateTime_manager.dart';
import '../database/database.dart';
import '../database/user_db.dart';
import '../database/appointments_db.dart';
import '../models/models.dart';
import '../controller/notification_service.dart';

class DatabaseCtrl extends ChangeNotifier {
  static AppDB appDB = AppDB(dbName: 'database.db');
  //String? email;
  static UserDB? userDatabase;
  static AppointmentDB? appointmentDatabase;
  //User? currentUser;
  //List<Appointment> _appointments = [];
  //List<Appointment> _filter = [];

  DatabaseCtrl() {
    DatabaseCtrl.initDB();
    NotificationService.initNotifications();
  }

  @override
  void dispose() {
    DatabaseCtrl.closeDB();
    super.dispose();
  }

  //--DB services
  static void initDB() async {
    if (kDebugMode) print('Database init trigger');
    await appDB.open();
    Database db = await appDB.getDB;
    userDatabase = UserDB(db: db);
    appointmentDatabase = AppointmentDB(db: db);
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

  get getAppointmentDB => appointmentDatabase;
  get getUserDB => userDatabase;

  /*
  //--User services
  Future<bool> signUpUser(User user) async {
    bool validate = await userDatabase!.create(user);
    if (validate) {
      currentUser = user;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<int> signInUser(String email, String password) async {
    User? tempUser = await userDatabase!.fetchUser(email);
    if (tempUser == null) {
      return 2;
    }
    if (tempUser.password == password) {
      currentUser = tempUser;
      notifyListeners();
      return 0;
    } else {
      return 1;
    }
  }

  Future<bool> updateUser(User user) async {
    bool validate = await userDatabase!.update(user);
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
    _appointments = await appointmentDatabase!.fetchAppointments(currentUser!);
    _filter = [];
    //_filter.addAll(_appointments);
    timeRatioAll();
    notifyListeners();
  }

  Future<bool> createAppointments(Appointment appointment) async {
    bool validate = await appointmentDatabase!.create(appointment);
    if (validate) {
      _appointments.add(appointment);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateAppointments(Appointment appointment) async {
    bool validate = await appointmentDatabase!.update(appointment);
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
        .where((element) => element.id != appointment.id)
        .toList();
    if (kDebugMode) print(_appointments);
    if (kDebugMode) print(isAvailable);
    return isAvailable.isEmpty;
  }

  void deleteAppointments(int id) async {
    bool validate = await appointmentDatabase!.delete(id);
    if (validate) {
      fetchAppointments();
      notifyListeners();
    }
  }

  get getAppointments => _filter;

  //--Filter
  void timeRatioAll() {
    _filter = _appointments
        .where((element) => DatetimeManager().compareNotPastDates(element.date))
        .toList();
    notifyListeners();
  }

  void timeRatioToday() {
    _filter = _appointments
        .where((element) => DatetimeManager().compareTodayDates(element.date))
        .toList();
    notifyListeners();
  }

  void timeRatioTomorrow() {
    _filter = _appointments
        .where((element) => element.date.day == DateTime.now().day + 1)
        .toList();
    notifyListeners();
  }

  void timeRatioPast() {
    _filter = _appointments
        .where((element) => DatetimeManager().comparePastDates(element.date))
        .toList();
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

  void sendNotification(Appointment appointment) {
    NotificationService.pushSchedule(appointment);
  }
   */
}
