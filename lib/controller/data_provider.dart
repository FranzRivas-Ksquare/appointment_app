import 'package:appointment/custom_widgets/time_ratio.dart';
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
  List<Appointment> appointments = [];
  static final List buttons = [
    "All",
    "Today",
    "Tomorrow",
    "Past",
  ];
  List<TimeRatio> timeRatioButtons = [];

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
        .where((element) => element.date == appointment.date)
        .toList();
    if (kDebugMode) print(appointments);
    if (kDebugMode) print(isAvailable);
    return isAvailable.isEmpty;
  }

  void deleteAppointments(int id) async {
    bool validate = await appointmentCtrl!.delete(id);
    if (validate) {
      appointments = appointments.where((element) => element.id != id).toList();
      notifyListeners();
    }
  }

  List<Appointment> timeRatio(DateTime dayRatio) {
    List<Appointment> filter =
        appointments.where((element) => element.date.day == dayRatio).toList();
    return filter;
  }

  List<Appointment> getTodayAppointments() {
    List<Appointment> filter = appointments
        .where((element) => DatetimeManager().compareTodayDates(element.date))
        .toList();
    return filter;
  }

  void fillTimeRatioArray() {
    if (timeRatioButtons.isEmpty) {
      for (int i = 0; i < 4; i++) {
        timeRatioButtons.add(TimeRatio(text: buttons[i], isSelect: false));
      }
      timeRatioButtons[0].isSelect = true;
    }
  }

  void changeTimeRatio(int index) {
    timeRatioButtons[index].isSelect = true;
    print(index);
    for (int i = 0; i < timeRatioButtons.length; i++) {
      if (timeRatioButtons[i].isSelect && i != index) {
        timeRatioButtons[i].isSelect = false;
      }
    }
    notifyListeners();
  }

  get getTimeRatioButtons => timeRatioButtons;
  get getAppointments => appointments;
}
