// ignore_for_file: constant_identifier_names

class ShalatModel {
  final Shalat shalat;
  final int hour;
  final int minute;
  final String time;
  ShalatModel(
      {required this.shalat,
      required this.hour,
      required this.minute,
      required this.time});
}

enum Shalat { Subuh, Dzuhur, Ashar, Maghrib, Isya }
