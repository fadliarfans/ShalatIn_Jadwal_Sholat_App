class MyJadwalModel {
  String? fajr;
  String? dhuhr;
  String? asr;
  String? maghrib;
  String? isha;
  int? day;
  int? month;
  int? year;
  MyJadwalModel(
      {required this.asr,
      required this.dhuhr,
      required this.fajr,
      required this.isha,
      required this.maghrib,
      required this.day,
      required this.month,
      required this.year});
}
