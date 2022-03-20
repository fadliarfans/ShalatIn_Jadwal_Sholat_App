mixin IAlarm {
  Future<void> playAdzan(DateTime date, int id);
  Future<void> cancelAdzan(int id);
}
