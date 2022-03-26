import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/data/my_jadwal_model.dart';
import 'package:jadwal_sholat_app/service/jadwal/i_jadwal.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';

import 'i_jadwal.dart';

class JadwalApiSecond with IJadwal {
  @override
  Future<Resource<MyJadwalModel>> getJadwal(MyLocationModel myLocation) {
    throw UnimplementedError();
  }
}
