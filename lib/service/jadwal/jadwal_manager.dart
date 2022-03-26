import 'package:jadwal_sholat_app/service/jadwal/i_jadwal.dart';
import '../../data/my_jadwal_model.dart';
import '../../vo/resource.dart';
import '../../data/my_location_model.dart';

class JadwalManager {
  IJadwal _iJadwal;
  JadwalManager(this._iJadwal);

  setIJadwal(IJadwal iJadwal) {
    _iJadwal = iJadwal;
  }

  Future<Resource<MyJadwalModel>> getJadwal(MyLocationModel location) async {
    return _iJadwal.getJadwal(location);
  }

  Future<void> saveJadwal(MyJadwalModel jadwal) async {
    _iJadwal.saveJadwal(jadwal);
  }
}
