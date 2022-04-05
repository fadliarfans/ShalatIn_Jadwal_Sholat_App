import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:jadwal_sholat_app/injection.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../data/models/shalat_model.dart';

@Injectable()
class NotificationManager {
  _time(hour, minute) {
    final time = tz.TZDateTime.now(tz.local);
    final nextTime =
        tz.TZDateTime(tz.local, time.year, time.month, time.day, hour, minute);
    return nextTime;
  }

  Future<void> cancelNotification(int id)async{
    await locator<FlutterLocalNotificationsPlugin>().cancel(id);
  }

  Future<void> setZonedScheduleNotification(
      int hour, int minute, Shalat shalat) async {
    await locator<FlutterLocalNotificationsPlugin>().zonedSchedule(
        shalat.index + 400,
        "${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, "0")}",
        "Ayo Shalat ${shalat.name}, udah masuk waktunya nih !",
        _time(hour, minute),
        NotificationDetails(
            android: AndroidNotificationDetails(
                '${shalat.name} ${400}', shalat.name,
                channelDescription: 'Shalat ${shalat.name} Notification')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
