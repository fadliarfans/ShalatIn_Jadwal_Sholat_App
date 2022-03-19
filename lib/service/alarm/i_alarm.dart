abstract class IAlarm {
  Future<void> playAdzan();
  Future<void> playAdzanOnTime(DateTime date, int id);
}
