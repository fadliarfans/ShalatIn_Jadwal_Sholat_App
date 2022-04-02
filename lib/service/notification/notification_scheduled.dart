import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../data/models/shalat_model.dart';

class NotificationScheduled {
  static tz.TZDateTime _time(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      // scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static Future<void> showFullScreenNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      int hour,
      int minute,
      Shalat shalat) async {
    print("Notification Scheduled");
    await flutterLocalNotificationsPlugin.zonedSchedule(
        shalat.index,
        '${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, "0")}',
        'Ayo sudah masuk waktu shalat ${shalat.name}',
        _time(hour, minute),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'full screen channel id', 'full screen channel name',
                channelDescription: 'full screen channel description',
                priority: Priority.high,
                importance: Importance.high,
                fullScreenIntent: true)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static Future<void> cancelNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Shalat shalat) async {
    print("Notification Canceled");
    await flutterLocalNotificationsPlugin.cancel(shalat.index);
  }
}
