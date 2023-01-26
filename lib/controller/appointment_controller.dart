import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../resources/dateTime_manager.dart';
import '../database/appointments_db.dart';
import '../controller/database_service.dart';
import '../controller/user_controller.dart';
import '../controller/notification_service.dart';
import '../models/appointment_model.dart';

class AppointmentCtrl extends ChangeNotifier {
  List<Appointment> _appointments = [];
  List<Appointment> _filter = [];

  //--Appointments services
  void fetchAppointments(BuildContext context) async {
    final AppointmentDB refAppointmentDB =
        context.read<DatabaseService>().getAppointmentDB;
    final currentUser = context.read<UserCtrl>().getCurrentUser;
    _appointments = await refAppointmentDB.fetchAppointments(currentUser);
    _filter = [];
    timeRatioAll();
    notifyListeners();
  }

  Future<bool> createAppointments(
      BuildContext context, Appointment appointment) async {
    final AppointmentDB refAppointmentDB =
        context.read<DatabaseService>().getAppointmentDB;
    if (appointment.date != DateTime.now() ||
        appointment.date.isAfter(DateTime.now().add(Duration(seconds: 30)))) {
      bool validate = await refAppointmentDB.create(appointment);
      if (validate) {
        _appointments.add(appointment);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> updateAppointments(
      BuildContext context, Appointment appointment) async {
    final AppointmentDB refAppointmentDB =
        context.read<DatabaseService>().getAppointmentDB;
    bool validate = await refAppointmentDB.update(appointment);
    if (validate) {
      fetchAppointments(context);
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

  void deleteAppointments(BuildContext context, int id) async {
    final AppointmentDB refAppointmentDB =
        context.read<DatabaseService>().getAppointmentDB;
    bool validate = await refAppointmentDB.delete(id);
    if (validate) {
      fetchAppointments(context);
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

  void deleteNotification(Appointment appointment) {
    NotificationService.deleteNotification(appointment);
  }
}
