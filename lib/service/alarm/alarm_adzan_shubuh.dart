import 'package:jadwal_sholat_app/service/alarm/i_alarm.dart';

class AlarmAdzanShubuh implements IAlarm {
  @override
  Future<void> playAdzan() async {}

  @override
  Future<void> playAdzanOnTime(DateTime date, int id) async {}
}
