import 'package:injectable/injectable.dart';
import 'package:jadwal_sholat_app/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/my_jadwal_model.dart';
import '../../models/my_location_model.dart';
import '../../models/shalat_model.dart';
import '../../models/time_model.dart';

@Injectable()
class JadwalDao {
  Future<void> saveActivatedJadwal(Shalat shalat, bool value) async {
    final prefs = await locator<SharedPreferences>();
    prefs.setBool("${shalat.name} Activated", value);
  }

  Future<Map<Shalat, bool>> getActivatedJadwal() async {
    final prefs = await locator<SharedPreferences>();
    final subuh = prefs.getBool("${Shalat.Subuh.name} Activated") ?? false;
    final dzuhur = prefs.getBool("${Shalat.Dzuhur.name} Activated") ?? false;
    final ashar = prefs.getBool("${Shalat.Ashar.name} Activated") ?? false;
    final maghrib = prefs.getBool("${Shalat.Maghrib.name} Activated") ?? false;
    final isya = prefs.getBool("${Shalat.Isya.name} Activated") ?? false;
    return {
      Shalat.Subuh: subuh,
      Shalat.Dzuhur: dzuhur,
      Shalat.Ashar: ashar,
      Shalat.Maghrib: maghrib,
      Shalat.Isya: isya
    };
  }

  Future<void> saveJadwal(MyJadwalModel jadwal) async {
    final prefs = await locator<SharedPreferences>();
    prefs.setString(Shalat.Subuh.name, jadwal.fajr.timeS);
    prefs.setString(Shalat.Dzuhur.name, jadwal.dhuhr.timeS);
    prefs.setString(Shalat.Ashar.name, jadwal.asr.timeS);
    prefs.setString(Shalat.Maghrib.name, jadwal.maghrib.timeS);
    prefs.setString(Shalat.Isya.name, jadwal.isha.timeS);
    prefs.setInt("day", jadwal.day);
    prefs.setInt("month", jadwal.month);
    prefs.setInt("year", jadwal.year);
  }

  Future<MyJadwalModel> getJadwal(MyLocationModel myLocation) async {
    final prefs = await locator<SharedPreferences>();
    final city = prefs.getString("cityId");
    if (city == myLocation.cityId) {
      final fajr = prefs.getString(Shalat.Subuh.name);
      final dhuhr = prefs.getString(Shalat.Dzuhur.name);
      final asr = prefs.getString(Shalat.Ashar.name);
      final maghrib = prefs.getString(Shalat.Maghrib.name);
      final isha = prefs.getString(Shalat.Isya.name);
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
      throw Exception("City Different !");
    }
  }
}
