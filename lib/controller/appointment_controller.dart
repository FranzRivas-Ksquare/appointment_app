import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../resources/dateTime_manager.dart';
import '../models/models.dart';

class AppontmentCtrl extends ChangeNotifier {

  List<Appointment> _appointments = [];
  List<Appointment> _filter = [];

  //--Appointments services
  void fetchAppointments(BuildContext context) async {
    _appointments = await appointmentCtrl!.fetchAppointments(currentUser!);
    _filter = [];
    //_filter.addAll(_appointments);
    timeRatioAll();
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
        .where((element) => element.id != appointment.id)
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
}