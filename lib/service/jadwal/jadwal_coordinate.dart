import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:jadwal_sholat_app/data/jadwal_response.dart';
import 'package:jadwal_sholat_app/data/my_jadwal_model.dart';
import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/service/jadwal/i_jadwal.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';

class JadwalCoordinate with IJadwal {
  @override
  Future<Resource<MyJadwalModel>> getJadwal(MyLocation myLocation) async {
    try {
      final now = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);
      final longitude = myLocation.long ?? 0.0;
      final latitude = myLocation.lat ?? 0.0;
      final elevation = myLocation.alt ?? 0.0;
      final response = await Dio().get(
          "https://api.pray.zone/v2/times/day.json?longitude=$longitude&latitude=$latitude&elevation=$elevation&date=$formattedDate");

      if (response.statusCode == 200) {
        final jadwal = JadwalResponse.fromJson(response.data);
        final times = jadwal.result?.listDateTime?.first.times;
        final myJadwal = MyJadwalModel(
            asr: times?.asr,
            dhuhr: times?.dhuhr,
            fajr: times?.fajr,
            isha: times?.isha,
            maghrib: times?.maghrib,
            day: now.day,
            month: now.month,
            year: now.year);
        try {
          super.saveToLocal(
              times?.fajr ?? "",
              times?.dhuhr ?? "",
              times?.asr ?? "",
              times?.maghrib ?? "",
              times?.isha ?? "",
              now.day,
              now.month,
              now.year);
        } catch (e) {
          return Resource<MyJadwalModel>().error("Save jadwal to Local error");
        }
        return Resource<MyJadwalModel>().success(myJadwal);
      } else {
        return Resource<MyJadwalModel>().error("Jadwal Error");
      }
    } catch (e) {
      return Resource<MyJadwalModel>().error(e.toString());
    }
  }
}
