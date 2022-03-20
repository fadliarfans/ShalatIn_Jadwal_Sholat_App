import 'package:jadwal_sholat_app/data/my_jadwal_model.dart';
import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin IJadwal {
  Future<Resource<MyJadwalModel>> getJadwal(MyLocation myLocation);

  Future<bool> saveToLocal(String fajr, String dhuhr, String asr,
      String maghrib, String isha, int day, int month, int year) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("fajr", fajr);
      prefs.setString("dhuhr", dhuhr);
      prefs.setString("asr", asr);
      prefs.setString("maghrib", maghrib);
      prefs.setString("isha", isha);
      prefs.setInt("day", day);
      prefs.setInt("month", month);
      prefs.setInt("year", year);
      return true;
    } catch (e) {
      return false;
    }
  }
}
