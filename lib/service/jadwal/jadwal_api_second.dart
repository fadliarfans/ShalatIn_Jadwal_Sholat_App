import 'package:dio/dio.dart';
import 'package:jadwal_sholat_app/data/jadwal_response_second_model.dart';
import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/data/my_jadwal_model.dart';
import 'package:jadwal_sholat_app/service/jadwal/i_jadwal.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';

import '../../data/time_model.dart';
import 'i_jadwal.dart';

class JadwalApiSecond with IJadwal {
  @override
  Future<Resource<MyJadwalModel>> getJadwal(MyLocationModel myLocation) async {
    try {
      final response = await Dio().get(
          "https://api.pray.zone/v2/times/today.json?city=${myLocation.city}");
      if (response.statusCode == 200) {
        final jadwal = JadwalResponseSecondModel.fromJson(response.data);
        final times = jadwal.results!.datetime!.first.times!;
        final now = DateTime.now();
        final myJadwal = MyJadwalModel(
            asr: Time(times.asr!),
            dhuhr: Time(times.dhuhr!),
            fajr: Time(times.fajr!),
            isha: Time(times.isha!),
            maghrib: Time(times.maghrib!),
            day: now.day,
            month: now.month,
            year: now.year);
        return Resource<MyJadwalModel>().success(myJadwal,
            message:
                "JADWAL SUCCESS ----> Jadwal From Second API Based On City");
      } else {
        return Resource<MyJadwalModel>()
            .error("JADWAL ERROR ----> Second API ERROR LOG :  Network Error");
      }
    } catch (e) {
      return Resource<MyJadwalModel>()
          .error("JADWAL ERRROR ----> Second API ERROR LOG : $e");
    }
  }
}
