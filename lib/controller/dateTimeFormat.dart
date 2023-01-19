import 'package:flutter/material.dart';

class DateTimeFormat {
  getDate(String appointment) {
    String dateNow = appointment.replaceAll('-', '/');
    return dateNow;
  }

  getTime(String appointment) {
    String timeString = appointment.substring(0, 5);
    double timeNumber = double.parse(timeString.replaceAll(':', '.'));
    if (timeNumber >= 13.00 && timeNumber <= 23.59) {
      String timeString =
          (timeNumber - 12.00).toStringAsFixed(2).replaceAll('.', ':');
      String timeNow = '$timeString PM';
      return timeNow;
    } else if (timeNumber >= 00.00 && timeNumber <= 00.59) {
      String timeString =
          (timeNumber + 12.00).toStringAsFixed(2).replaceAll('.', ':');
      String timeNow = '$timeString AM';
      return timeNow;
    } else {
      String timeNow = '$timeString AM';
      return timeNow;
    }
  }
}
