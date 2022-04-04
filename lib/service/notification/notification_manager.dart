import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:jadwal_sholat_app/injection.dart';
import 'package:timezone/timezone.dart' as tz;

@Injectable()
class NotificationManager {
  _time(hour, minute) {
    final time = tz.TZDateTime.now(tz.local);
    final nextTime =
        tz.TZDateTime(tz.local, time.year, time.month, time.day, hour, minute);
    return nextTime;
  }

  Future<void> setZonedScheduleNotification(int hour, int minute) async {
    await locator<FlutterLocalNotificationsPlugin>().zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        _time(hour, minute),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
