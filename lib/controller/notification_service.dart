import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../models/models.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initNotifications() async {
    final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    final AndroidInitializationSettings _androidInitializationSettings =
        AndroidInitializationSettings('logo');
    final DarwinInitializationSettings _initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    InitializationSettings initializationSettings = InitializationSettings(
        android: _androidInitializationSettings,
        iOS: _initializationSettingsIOS);
    tz.initializeTimeZones();
    tz.setLocalLocation(
      tz.getLocation(
        await FlutterNativeTimezone.getLocalTimezone(),
      ),
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    print("Notification Service.");
  }

  static Future<void> sendNotification(String title, String body) async {
    final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "channelId",
      "channelName",
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );
    DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(threadIdentifier: "thread2");
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
  }

  static Future<void> pushSchedule(Appointment appointment) async {
    tz.TZDateTime todayDate = tz.TZDateTime.now(tz.local);
    Duration diff = appointment.date.difference(todayDate);
    tz.TZDateTime finalDate = todayDate.add(diff);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("id", "channel_Name",
            importance: Importance.max,
            priority: Priority.max,
            playSound: true,
            sound: const RawResourceAndroidNotificationSound('listen'));
    DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(threadIdentifier: "thread2");
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    await FlutterLocalNotificationsPlugin().zonedSchedule(
        appointment.id,
        appointment.title,
        appointment.description,
        finalDate,
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static tz.TZDateTime calculateTimeDifference(Appointment appointment) {
    tz.TZDateTime todayDate = tz.TZDateTime.now(tz.local);
    print(appointment.date);
    Duration diff = appointment.date.difference(todayDate);
    var finalDate = todayDate.add(diff);
    return finalDate;
  }
}
