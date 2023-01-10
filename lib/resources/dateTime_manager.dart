import 'package:intl/intl.dart';

class DatetimeManager {
  String dateToFormat = '';
  String timeToFormat = '';
  String dtTogether = '';

  DatetimeManager() {}

  String dateTimeParse(dateNow, timeNow) {
    if (dateNow.isNotEmpty && timeNow.isNotEmpty) {
      dateToFormat = dateNow.replaceAll('/', '-');
      if (timeNow.contains('AM')) {
        double timeNumber = double.parse(timeNow
            .replaceAll('AM', '')
            .replaceAll('PM', '')
            .replaceAll(':', '.')
            .replaceAll(' ', ''));
        if (timeNumber >= 12.00) {
          timeNumber = timeNumber - 12.00;
          timeToFormat =
              '0${timeNumber.toStringAsFixed(2).replaceAll('.', ':')}:00.000000';
        } else if (timeNumber >= 1.00 && timeNumber <= 9.59) {
          timeToFormat =
              '0${timeNumber.toStringAsFixed(2).replaceAll('.', ':')}:00.000000';
        } else {
          timeToFormat =
              '${timeNow.replaceAll('AM', '').replaceAll('PM', '').replaceAll(' ', '')}:00.000000';
        }
      } else if (timeNow.contains('PM')) {
        double timeNumber = double.parse(timeNow
            .replaceAll('AM', '')
            .replaceAll('PM', '')
            .replaceAll(':', '.')
            .replaceAll(' ', ''));
        timeNumber = timeNumber + 12;
        timeToFormat =
            '${timeNumber.toStringAsFixed(2).replaceAll('.', ':')}:00.000000';
      }
      dtTogether = '$dateToFormat $timeToFormat';
      return dtTogether;
    } else {
      return "";
    }
  }

  bool comparePastDates(DateTime dt) {
    DateTime today = DateTime.now();
    if (today.year > dt.year) return true;
    if (today.year >= dt.year && today.month > dt.month) return true;
    if (today.year >= dt.year && today.month >= dt.month && today.day > dt.day) {
      return true;
    }
    return false;
  }

  bool compareNotPastDates(DateTime dt) {
    DateTime today = DateTime.now();
    if (today.year < dt.year) return true;
    if (today.year <= dt.year && today.month < dt.month) return true;
    if (today.year <= dt.year && today.month <= dt.month && today.day < dt.day) {
     return true;
    }
    return false;
  }
}
