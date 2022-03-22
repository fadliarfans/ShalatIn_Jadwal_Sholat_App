import 'package:flutter/foundation.dart';
import 'package:jadwal_sholat_app/data/my_jadwal_model.dart';
import 'package:jadwal_sholat_app/service/jadwal/jadwal_city.dart';
import 'package:jadwal_sholat_app/service/jadwal/jadwal_local.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';
import 'package:jadwal_sholat_app/vo/status.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/my_location_model.dart';

class JadwalManager {
  Future<void> saveJadwal(String fajr, String dhuhr, String asr, String maghrib,
      String isha, int day, int month, int year) async {
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
    } catch (e) {
      rethrow;
    }
  }

  Future<Resource<MyJadwalModel>> getJadwal(MyLocation location) async {
    try {
      Resource<MyJadwalModel>? resourceJadwal;
      final prefs = await SharedPreferences.getInstance();
      final cityId = prefs.getString("cityId");
      final day = prefs.getInt("day");
      final month = prefs.getInt("month");
      final year = prefs.getInt("year");
      final now = DateTime.now();

      // Jika Lokasi dan tanggal sama dengan yang disimpan, maka data diambil dari lokal.
      if (cityId == location.cityId &&
          day == now.day &&
          month == now.month &&
          year == now.year) {
        resourceJadwal = await JadwalLocal().getJadwal(location);
        if (kDebugMode) {
          print("Jadwal from Local Message : ${resourceJadwal.message}");
        }
      } else {
        resourceJadwal = await JadwalCity().getJadwal(location);
        if (kDebugMode) {
          print("Jadwal from API Message : ${resourceJadwal.message}");
        }
        if (resourceJadwal.status == Status.SUCCES) {
          final times = resourceJadwal.data;
          saveJadwal(times!.fajr!, times.dhuhr!, times.asr!, times.maghrib!,
              times.isha!, times.day!, times.month!, times.year!);
        }
      }

      if (resourceJadwal.status == Status.SUCCES) {
        return resourceJadwal;
      } else {
        return Resource<MyJadwalModel>()
            .error(resourceJadwal.message ?? "Jadwal Error");
      }
    } catch (e) {
      return Resource<MyJadwalModel>().error(e.toString());
    }
  }
}
