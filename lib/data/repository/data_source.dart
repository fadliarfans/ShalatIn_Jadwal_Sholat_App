import 'package:jadwal_sholat_app/data/models/my_location_model.dart';

import '../../vo/resource.dart';
import '../models/my_jadwal_model.dart';
import '../models/shalat_model.dart';

abstract class DataSource {
  Future<Resource<List<MyJadwalModel>>> getJadwal(MyLocationModel location);

  Future<Resource<MyLocationModel>> getLocation();

  Future<Resource<Map<Shalat, bool>>> getActivatedJadwal();

  Future<Resource<bool>> saveJadwal(List<MyJadwalModel> myJadwal);

  Future<Resource<bool>> saveLocation(MyLocationModel location);

  Future<Resource<bool>> saveActivatedJadwal(Shalat shalat, bool value);
}
