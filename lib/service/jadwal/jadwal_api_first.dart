import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../../data/jadwal_response_first_model.dart';
import '../../data/my_jadwal_model.dart';
import '../../data/my_location_model.dart';
import 'i_jadwal.dart';
import '../../vo/resource.dart';

class JadwalApiFirst with IJadwal {
  @override
  Future<Resource<MyJadwalModel>> getJadwal(MyLocationModel myLocation) async {
    try {
      final now = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);

      final response = await Dio().get(
          "https://jadwal-shalat-api.herokuapp.com/daily?date=$formattedDate&cityId=${myLocation.cityId}");

      if (response.statusCode == 200) {
        final jadwal = JadwalResponseFirst.fromJson(response.data);
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
        return Resource<MyJadwalModel>().success(myJadwal,
            message: "JADWAL SUCCESS ----> Get Jadwal From API Based On City");
      } else {
        return Resource<MyJadwalModel>()
            .error("JADWAl ERROR ----> Network Jadwal Error");
      }
    } catch (e) {
      return Resource<MyJadwalModel>()
          .error("JADWAL ERROR ----> ${e.toString()}");
    }
  }
}
