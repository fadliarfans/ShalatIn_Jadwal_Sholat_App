import 'package:injectable/injectable.dart';
import 'package:jadwal_sholat_app/data/repository/local/jadwal_dao.dart';
import 'package:jadwal_sholat_app/data/repository/local/location_dao.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';

import '../../models/my_jadwal_model.dart';
import '../../models/my_location_model.dart';
import '../../models/shalat_model.dart';

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
          message:
              "LOCATION SUCCESS ----> Location From Local = ${myLocation.city}");
    } catch (e) {
      return Resource<MyLocationModel>().error("LOCATION ERROR ----> $e");
    }
  }

  Future<Resource<bool>> saveJadwal(List<MyJadwalModel> myJadwalList) async {
    try {
      await _jadwalDao.saveJadwal(myJadwalList);
      return Resource<bool>()
          .success(true, message: "JADWAL SUCCESS ----> Save Success");
    } catch (e) {
      return Resource<bool>().error("JADWAL ERROR ----> $e");
    }
  }

  Future<Resource<List<MyJadwalModel>>> getJadwal(
      MyLocationModel myLocation) async {
    try {
      final myJadwalList = await _jadwalDao.getJadwal(myLocation);
      return Resource<List<MyJadwalModel>>().success(myJadwalList,
          message: "JADWAL SUCCESS ----> Jadwal from Local");
    } catch (e) {
      return Resource<List<MyJadwalModel>>().error("JADWAL ERROR ----> $e");
    }
  }

  Future<Resource<bool>> saveActivatedJadwal(Shalat shalat, bool value) async {
    try {
      await _jadwalDao.saveActivatedJadwal(shalat, value);
      return Resource<bool>().success(true,
          message: "JADWAL ACTIVATED SUCCESS ----> Save Success");
    } catch (e) {
      return Resource<bool>().error("JADWAL ACTIVATED ERROR ----> $e");
    }
  }

  Future<Resource<Map<Shalat, bool>>> getActivatedJadwal() async {
    try {
      final myActivatedJadwal = await _jadwalDao.getActivatedJadwal();
      return Resource<Map<Shalat, bool>>().success(myActivatedJadwal,
          message: "JADWAL ACTIVATED SUCCESS ----> Get All Activated Jadwal");
    } catch (e) {
      return Resource<Map<Shalat, bool>>()
          .error("JADWAL ACTIVATED ERROR ----> $e");
    }
  }
}
