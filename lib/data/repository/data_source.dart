import 'package:jadwal_sholat_app/data/models/my_location_model.dart';

import '../../vo/resource.dart';
import '../models/my_jadwal_model.dart';

abstract class DataSource {
  Future<Resource<MyJadwalModel>> getJadwal(MyLocationModel location);

  Future<Resource<MyLocationModel>> getLocation();

  Future<Resource<bool>> saveJadwal(MyJadwalModel myJadwal);

  Future<Resource<bool>> saveLocation(MyLocationModel location);
}
