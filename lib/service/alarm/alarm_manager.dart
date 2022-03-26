import 'i_alarm.dart';

class AlarmManager {
  final IAlarm iAlarm;
  AlarmManager({required this.iAlarm});

  void playAlarmOnTime(DateTime date, int id) {
    iAlarm.playAdzan(date, id);
  }

  void cancelAdzan(int id) {
    iAlarm.cancelAdzan(id);
  }
}
