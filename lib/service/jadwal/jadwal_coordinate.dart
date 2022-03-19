import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:jadwal_sholat_app/data/jadwal_response.dart';
import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/service/jadwal/i_jadwal.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';

class JadwalCoordinate extends IJadwal {
  @override
  Future<Resource<JadwalResponse>> getJadwal(MyLocation myLocation) async {
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
        return Resource<JadwalResponse>().success(jadwal);
      } else {
        return Resource<JadwalResponse>().error("Jadwal Error");
      }
    } catch (e) {
      return Resource<JadwalResponse>().error(e.toString());
    }
  }
}
