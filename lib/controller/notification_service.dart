import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../models/appointment_model.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails("id", "channel_Name",
          importance: Importance.max,
          priority: Priority.max,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('listen'));
  static const DarwinNotificationDetails iosNotificationDetails =
      DarwinNotificationDetails(threadIdentifier: "thread2");
  static Future<void> initNotifications() async {
    final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings _androidInitializationSettings =
        AndroidInitializationSettings('logo');
    const DarwinInitializationSettings _initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    InitializationSettings initializationSettings = const InitializationSettings(
        android: _androidInitializationSettings,
        iOS: _initializationSettingsIOS);
    tz.initializeTimeZones();
    tz.setLocalLocation(
      tz.getLocation(
        await FlutterNativeTimezone.getLocalTimezone(),
      ),
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    if (kDebugMode) print("Notification Service.");
  }

  static Future<void> sendNotification(String title, String body) async {
    NotificationDetails notificationDetails = const NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
  }

  static Future<void> pushSchedule(Appointment appointment) async {
    tz.TZDateTime todayDate = tz.TZDateTime.now(tz.local);
    if (kDebugMode) print("todayDate: $todayDate");
    Duration diff = appointment.date.difference(todayDate);
    if (kDebugMode) print("diff: $diff");
    tz.TZDateTime finalDate = todayDate.add(diff);
    if (kDebugMode) print("finalDate: $finalDate");
    NotificationDetails notificationDetails = const NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        appointment.id,
        appointment.title,
        appointment.description,
        finalDate,
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static Future<void> deleteNotification(Appointment appointment) async {
    await _flutterLocalNotificationsPlugin.cancel(appointment.id);
    if (kDebugMode) print("Notification ${appointment.id} deleted.");
  }

  static tz.TZDateTime calculateTimeDifference(Appointment appointment) {
    tz.TZDateTime todayDate = tz.TZDateTime.now(tz.local);
    if (kDebugMode) print(appointment.date);
    Duration diff = appointment.date.difference(todayDate);
    var finalDate = todayDate.add(diff);
    return finalDate;
  }
}
