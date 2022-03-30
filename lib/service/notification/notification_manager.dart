import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jadwal_sholat_app/data/shalat_model.dart';
import 'package:jadwal_sholat_app/service/notification/notification_init.dart';
import 'package:jadwal_sholat_app/service/notification/notification_scheduled.dart';

class NotificationManager {
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  static void init() async {
    try {
      flutterLocalNotificationsPlugin ??= await InitNotification.getPlugin();
    } catch (e) {
      rethrow;
    }
  }

  static void setScheduleNotification(int hour, int minute, Shalat shalat) {
    try {
      NotificationScheduled.showFullScreenNotification(
          flutterLocalNotificationsPlugin!, hour, minute, shalat);
    } catch (e) {
      rethrow;
    }
  }

  static void cancelNotification(int hour, int minute, Shalat shalat) {
    try {
      NotificationScheduled.cancelNotification(
          flutterLocalNotificationsPlugin!, shalat);
    } catch (e) {
      rethrow;
    }
  }

  NotificationManager() {
    init();
  }
}
