import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:jadwal_sholat_app/data/repository/local/shared_preference/jadwal_dao.dart';
import 'package:jadwal_sholat_app/data/repository/local/shared_preference/location_dao.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';

import '../../models/my_jadwal_model.dart';
import '../../models/my_location_model.dart';

@Injectable()
class LocalDataSource {
  late final LocationDao _locationDao;
  late final JadwalDao _jadwalDao;

  LocalDataSource(this._locationDao, this._jadwalDao);

  Future<Resource<bool>> saveLocation(MyLocationModel location) async {
    try {
      await _locationDao.saveLocation(location);
      return Resource<bool>()
          .success(true, message: "LOCATION SUCCESS ----> Save Success");
    } catch (e) {
      return Resource<bool>().error("LOCATION ERROR ----> $e");
    }
  }

  Future<Resource<MyLocationModel>> getLocation() async {
    try {
      final myLocation = await _locationDao.getLocation();
      return Resource<MyLocationModel>().success(myLocation,
          message: "LOCATION SUCCESS ----> Location From Local");
    } catch (e) {
      return Resource<MyLocationModel>().error("LOCATION ERROR ----> $e");
    }
  }

  Future<Resource<bool>> saveJadwal(MyJadwalModel myJadwal) async {
    try {
      await _jadwalDao.saveJadwal(myJadwal);
      return Resource<bool>()
          .success(true, message: "JADWAL SUCCESS ----> Save Success");
    } catch (e) {
      return Resource<bool>().error("JADWAL ERROR ----> $e");
    }
  }

  Future<Resource<MyJadwalModel>> getJadwal(MyLocationModel myLocation) async {
    try {
      final myJadwal = await _jadwalDao.getJadwal(myLocation);
      return Resource<MyJadwalModel>()
          .success(myJadwal, message: "JADWAL SUCCESS ----> Jadwal from Local");
    } catch (e) {
      return Resource<MyJadwalModel>().error("JADWAL ERROR ----> $e");
    }
  }
}
