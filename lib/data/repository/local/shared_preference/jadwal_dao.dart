import 'package:injectable/injectable.dart';

import '../../../models/my_jadwal_model.dart';
import '../../../models/my_location_model.dart';
import '../../../models/time_model.dart';
import 'cache.dart';


@Injectable()
class JadwalDao {
  final Cache _cache;

  JadwalDao(this._cache);

  Future<void> saveJadwal(MyJadwalModel jadwal) async {
    final prefs = _cache.pref;
    prefs.setString("fajr", jadwal.fajr.timeS);
    prefs.setString("dhuhr", jadwal.dhuhr.timeS);
    prefs.setString("asr", jadwal.asr.timeS);
    prefs.setString("maghrib", jadwal.maghrib.timeS);
    prefs.setString("isha", jadwal.isha.timeS);
    prefs.setInt("day", jadwal.day);
    prefs.setInt("month", jadwal.month);
    prefs.setInt("year", jadwal.year);
  }

  Future<MyJadwalModel> getJadwal(MyLocationModel myLocation) async {
    final prefs = _cache.pref;
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
          asr: Time(asr!),
          dhuhr: Time(dhuhr!),
          fajr: Time(fajr!),
          isha: Time(isha!),
          maghrib: Time(maghrib!),
          day: day!,
          month: month!,
          year: year!);
      return myJadwal;
    } else {
      throw Exception("JADWAL ERROR ------> City Different !");
    }
  }
}
