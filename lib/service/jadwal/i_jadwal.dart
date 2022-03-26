import 'package:shared_preferences/shared_preferences.dart';

import '../../data/my_jadwal_model.dart';
import '../../data/my_location_model.dart';
import '../../vo/resource.dart';

mixin IJadwal {
  Future<Resource<MyJadwalModel>> getJadwal(MyLocationModel myLocation);

  Future<void> saveJadwal(MyJadwalModel jadwal) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("fajr", jadwal.fajr.timeS);
      prefs.setString("dhuhr", jadwal.dhuhr.timeS);
      prefs.setString("asr", jadwal.asr.timeS);
      prefs.setString("maghrib", jadwal.maghrib.timeS);
      prefs.setString("isha", jadwal.isha.timeS);
      prefs.setInt("day", jadwal.day);
      prefs.setInt("month", jadwal.month);
      prefs.setInt("year", jadwal.year);
    } catch (e) {
      rethrow;
    }
  }
}
