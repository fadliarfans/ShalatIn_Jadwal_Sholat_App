import 'package:jadwal_sholat_app/data/models/my_jadwal_entity.dart';
import 'package:jadwal_sholat_app/data/models/shalat_model.dart';
import 'package:jadwal_sholat_app/data/models/time_model.dart';

class MyJadwalModel {
  Time fajr;
  Time dhuhr;
  Time asr;
  Time maghrib;
  Time isha;
  int day;
  int month;
  int year;
  MyJadwalModel(
      {required this.asr,
      required this.dhuhr,
      required this.fajr,
      required this.isha,
      required this.maghrib,
      required this.day,
      required this.month,
      required this.year});

  Time getTime(Shalat shalat) {
    switch (shalat) {
      case Shalat.Subuh:
        return fajr;
      case Shalat.Dzuhur:
        return dhuhr;
      case Shalat.Ashar:
        return asr;
      case Shalat.Maghrib:
        return maghrib;
      case Shalat.Isya:
        return isha;
    }
  }

  @override
  String toString() {
    return "date : $day-$month-$year fajr : ${fajr.timeS}, dhuhr : ${dhuhr.timeS}, ashar : ${asr.timeS}, maghrib : ${maghrib.timeS}, isya : ${isha.timeS} \n";
  }

  MyJadwalEntity toMyJadwalEntity() {
    return MyJadwalEntity(fajr.timeS, dhuhr.timeS, asr.timeS, maghrib.timeS,
        isha.timeS, day, month, year);
  }
}
