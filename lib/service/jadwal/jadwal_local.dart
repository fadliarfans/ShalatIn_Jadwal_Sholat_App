import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/data/my_jadwal_model.dart';
import 'package:jadwal_sholat_app/service/jadwal/i_jadwal.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JadwalLocal with IJadwal {
  @override
  Future<Resource<MyJadwalModel>> getJadwal(MyLocation myLocation) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final city = prefs.getString("cityId");
      if (city == myLocation.cityId) {
        final fajr = prefs.getString("fajr");
        final dhuhr = prefs.getString("dhuhr");
        final asr = prefs.getString("asr");
        final maghrib = prefs.getString("maghrib");
        final isha = prefs.getString("isha");
        final day = prefs.getInt("day");
        final month = prefs.getInt("month");
        final year = prefs.getInt("year");
        final myJadwal = MyJadwalModel(
            asr: asr,
            dhuhr: dhuhr,
            fajr: fajr,
            isha: isha,
            maghrib: maghrib,
            day: day,
            month: month,
            year: year);
        return Resource<MyJadwalModel>().success(myJadwal);
      } else {
        return Resource<MyJadwalModel>().error("Location Doesn't Match");
      }
    } catch (e) {
      return Resource<MyJadwalModel>().error(e.toString());
    }
  }
}
