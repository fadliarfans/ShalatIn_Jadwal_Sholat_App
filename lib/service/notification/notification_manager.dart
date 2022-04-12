import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../data/models/shalat_model.dart';

class NotificationManager {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {});

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
    });
  }

  Future<void> showNotificationSubuh() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'N-SUBUH', 'Shubuh Notification',
        timeoutAfter: 60 * 1000,
        channelDescription: 'Shalat Subuh Notification',
        importance: Importance.max,
        priority: Priority.high);
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        500,
        "Subuh",
        "Ayo Shalat Subuh, udah masuk waktunya nih !",
        platformChannelSpecifics);
  }

  Future<void> showNotificationDzuhur() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'N-DZUHUR', 'Dzuhur Notification',
        timeoutAfter: 60 * 1000,
        channelDescription: 'Shalat Dzuhur Notification',
        importance: Importance.max,
        priority: Priority.high);
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        501,
        "Dzuhur",
        "Ayo Shalat Dzuhur, udah masuk waktunya nih !",
        platformChannelSpecifics);
  }

  Future<void> showNotificationAshar() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'N-ASHAR', 'Ashar Notification',
        timeoutAfter: 60 * 1000,
        channelDescription: 'Shalat Ashar Notification',
        importance: Importance.max,
        priority: Priority.high);
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        502,
        "Ashar",
        "Ayo Shalat Ashar, udah masuk waktunya nih !",
        platformChannelSpecifics);
  }

  Future<void> showNotificationMaghrib() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'N-MAGHRIB', 'Maghrib Notification',
        timeoutAfter: 60 * 1000,
        channelDescription: 'Shalat Maghrib Notification',
        importance: Importance.max,
        priority: Priority.high);
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        503,
        "Maghrib",
        "Ayo Shalat Maghrib, udah masuk waktunya nih !",
        platformChannelSpecifics);
  }

  Future<void> showNotificationIsya() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'N-ISYA', 'Isya Notification',
        timeoutAfter: 60 * 1000,
        channelDescription: 'Shalat Isya Notification',
        importance: Importance.max,
        priority: Priority.high);
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(504, "Isya",
        "Ayo Shalat Isya, udah masuk waktunya nih !", platformChannelSpecifics);
  }

  Future<void> cancelNotification(Shalat shalat) async {
    try {
      final idNotification = shalat.index + 500;
      await flutterLocalNotificationsPlugin.cancel(idNotification);
    } catch (e) {
      rethrow;
    }
  }
}

//   _time(hour, minute) {
//     final time = tz.TZDateTime.now(tz.local);
//     final nextTime =
//         tz.TZDateTime(tz.local, time.year, time.month, time.day, hour, minute);
//     return nextTime;
//   }

// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

//
// Future<void> configureLocalTimeZone() async {
//   tz.initializeTimeZones();
//   final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//   tz.setLocalLocation(tz.getLocation(timeZoneName!));
// }
