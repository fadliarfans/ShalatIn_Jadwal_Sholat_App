import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../../data/jadwal_response_first_model.dart';
import '../../data/my_jadwal_model.dart';
import '../../data/my_location_model.dart';
import '../../data/time_model.dart';
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
        final jadwal = JadwalResponseFirstModel.fromJson(response.data);
        final times = jadwal.data?.data;
        final myJadwal = MyJadwalModel(
            asr: Time(times![2].time!),
            dhuhr: Time(times[1].time!),
            fajr: Time(times[0].time!),
            isha: Time(times[4].time!),
            maghrib: Time(times[3].time!),
            day: now.day,
            month: now.month,
            year: now.year);
        return Resource<MyJadwalModel>().success(myJadwal,
            message:
                "JADWAL SUCCESS ----> Jadwal From First API Based On City");
      } else {
        return Resource<MyJadwalModel>()
            .error("JADWAl ERROR ----> First API ERROR LOG : Network Error");
      }
    } catch (e) {
      return Resource<MyJadwalModel>()
          .error("JADWAL ERROR ----> First API ERROR LOG : $e");
    }
  }
}
