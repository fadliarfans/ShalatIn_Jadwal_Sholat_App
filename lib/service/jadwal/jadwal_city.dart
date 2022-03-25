import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:jadwal_sholat_app/data/my_jadwal_model.dart';
import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/service/jadwal/i_jadwal.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';

import '../../data/jadwal_sholat_response/jadwal_response.dart';

class JadwalCity with IJadwal {
  @override
  Future<Resource<MyJadwalModel>> getJadwal(MyLocation myLocation) async {
    try {
      final now = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);

      final response = await Dio().get(
          "https://jadwal-shalat-api.herokuapp.com/daily?date=$formattedDate&cityId=${myLocation.cityId}");

      if (response.statusCode == 200) {
        final jadwal = JadwalModel.fromJson(response.data);
        final times = jadwal.data?.data;
        final myJadwal = MyJadwalModel(
            asr: times![2].time,
            dhuhr: times[1].time,
            fajr: times[0].time,
            isha: times[4].time,
            maghrib: times[3].time,
            day: now.day,
            month: now.month,
            year: now.year);
        return Resource<MyJadwalModel>().success(myJadwal);
      } else {
        return Resource<MyJadwalModel>().error("Network Jadwal Error");
      }
    } catch (e) {
      return Resource<MyJadwalModel>().error(e.toString());
    }
  }
}
