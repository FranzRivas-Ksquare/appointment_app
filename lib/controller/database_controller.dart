import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../database/database.dart';
import '../database/user_db.dart';
import '../database/appointments_db.dart';
import '../controller/notification_service.dart';

class DatabaseCtrl extends ChangeNotifier {
  static AppDB appDB = AppDB(dbName: 'database.db');
  static UserDB? userDatabase;
  static AppointmentDB? appointmentDatabase;

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

}
