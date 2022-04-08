import 'package:jadwal_sholat_app/data/models/time_model.dart';
import 'package:objectbox/objectbox.dart';

import 'my_jadwal_model.dart';

@Entity()
class MyJadwalEntity {
  int id = 0;
  String fajr = "";
  String dhuhr = "";
  String asr = "";
  String maghrib = "";
  String isha = "";
  int day = 0;
  int month = 0;
  int year = 0;

  toMyJadwalModel() {
    return MyJadwalModel(
        asr: Time(asr),
        dhuhr: Time(dhuhr),
        fajr: Time(fajr),
        isha: Time(isha),
        maghrib: Time(maghrib),
        day: day,
        month: month,
        year: year);
  }
}
