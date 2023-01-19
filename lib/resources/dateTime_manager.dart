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

  bool compareTodayDates(DateTime dt) {
    DateTime today = DateTime.now();
    // Minute validation
    if (today.year == dt.year
        && today.month == dt.month
        && today.day == dt.day
        && today.hour <= dt.hour
        && today.minute <= dt.minute) return true;
    return false;
  }

  bool comparePastDates(DateTime dt) {
    return !compareNotPastDates(dt);
  }

  bool compareNotPastDates(DateTime dt) {
    DateTime today = DateTime.now();
    // Year validation
    if (today.year < dt.year) return true;
    // Month validation
    if (today.year <= dt.year
        && today.month < dt.month) return true;
    // Day validation
    if (today.year <= dt.year
        && today.month <= dt.month
        && today.day < dt.day) return true;
    // Hour validation
    if (today.year <= dt.year
        && today.month <= dt.month
        && today.day <= dt.day
        && today.hour < dt.hour) return true;
    // Minute validation
    if (today.year <= dt.year
        && today.month <= dt.month
        && today.day <= dt.day
        && today.hour <= dt.hour
        && today.minute <= dt.minute) return true;
    return false;
  }
}
