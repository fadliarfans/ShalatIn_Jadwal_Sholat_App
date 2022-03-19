import 'package:jadwal_sholat_app/data/jadwal_response.dart';
import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';

abstract class IJadwal {
  Future<Resource<JadwalResponse>> getJadwal(MyLocation myLocation);
}
