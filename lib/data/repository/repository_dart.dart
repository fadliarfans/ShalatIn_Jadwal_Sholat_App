import 'package:injectable/injectable.dart';
import 'package:jadwal_sholat_app/data/models/my_jadwal_model.dart';
import 'package:jadwal_sholat_app/data/models/my_location_model.dart';
import 'package:jadwal_sholat_app/data/models/shalat_model.dart';
import 'package:jadwal_sholat_app/data/repository/data_source.dart';
import 'package:jadwal_sholat_app/data/repository/local/local_data_source.dart';
import 'package:jadwal_sholat_app/data/repository/remote/remote_data_source.dart';
import 'package:jadwal_sholat_app/vo/status.dart';

import '../../vo/resource.dart';

@Injectable()
class Repository implements DataSource {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  Repository(this._localDataSource, this._remoteDataSource);

  @override
  Future<Resource<bool>> saveLocation(MyLocationModel location) async {
    Resource<bool> result = await _localDataSource.saveLocation(location);
    return result;
  }

  @override
  Future<Resource<MyLocationModel>> getLocation() async {
    Resource<MyLocationModel> resourceMyLocation =
        await _remoteDataSource.getLocation();

    if (resourceMyLocation.status == Status.ERROR) {
      resourceMyLocation = await _localDataSource.getLocation();
    }

    return resourceMyLocation;
  }

  @override
  Future<Resource<bool>> saveJadwal(List<MyJadwalModel> myJadwal) async {
    Resource<bool> result = await _localDataSource.saveJadwal(myJadwal);
    return result;
  }

  @override
  Future<Resource<List<MyJadwalModel>>> getJadwal(
      MyLocationModel myLocation) async {
    Resource<List<MyJadwalModel>> resourceMyJadwalList =
        await _localDataSource.getJadwal(myLocation);

    if (resourceMyJadwalList.status == Status.ERROR) {
      resourceMyJadwalList = await _remoteDataSource.getJadwal(myLocation);
      if (resourceMyJadwalList.status == Status.SUCCES) {
        _localDataSource.saveJadwal(resourceMyJadwalList.data!);
      }
    }
    return resourceMyJadwalList;
  }

  @override
  Future<Resource<Map<Shalat, bool>>> getActivatedJadwal() async {
    Resource<Map<Shalat, bool>> resourceMyActivatedJadwal =
        await _localDataSource.getActivatedJadwal();
    return resourceMyActivatedJadwal;
  }

  @override
  Future<Resource<bool>> saveActivatedJadwal(Shalat shalat, bool value) async {
    Resource<bool> result =
        await _localDataSource.saveActivatedJadwal(shalat, value);
    return result;
  }

  @override
  Future<Resource<List<MyJadwalModel>>> getJadwalLocal() async {
    Resource<List<MyJadwalModel>> resourceMyJadwalList =
        await _localDataSource.getJadwalWithoutLocation();
    return resourceMyJadwalList;
  }

  @override
  Future<Resource<MyJadwalModel>> getLocalJadwalById(int id) async {
    Resource<MyJadwalModel> resourceMyJadwal =
        await _localDataSource.getJadwalById(id);
    return resourceMyJadwal;
  }
}
