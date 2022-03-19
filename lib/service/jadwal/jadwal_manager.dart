import 'package:jadwal_sholat_app/data/jadwal_response.dart';
import 'package:jadwal_sholat_app/service/jadwal/i_jadwal.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';

import '../../data/my_location_model.dart';

class JadwalManager {
  final IJadwal iJadwal;

  JadwalManager(this.iJadwal);

  Future<Resource<JadwalResponse>> getJadwal(MyLocation location) {
    return iJadwal.getJadwal(location);
  }
}
