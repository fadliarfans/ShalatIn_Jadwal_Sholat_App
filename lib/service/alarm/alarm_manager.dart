import 'package:jadwal_sholat_app/service/alarm/i_alarm.dart';

class AlarmManager {
  final IAlarm iAlarm;
  AlarmManager({required this.iAlarm});

  void playAlarm() {
    iAlarm.playAdzan();
  }

  void playAlarmOnTime(DateTime date, int id) {
    iAlarm.playAdzanOnTime(date, id);
  }
}
