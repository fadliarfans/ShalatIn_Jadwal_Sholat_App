import 'package:injectable/injectable.dart';
import 'package:jadwal_sholat_app/data/models/my_jadwal_model.dart';
import 'package:jadwal_sholat_app/data/models/my_location_model.dart';
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
    Resource<MyLocationModel> myLocation = await _localDataSource.getLocation();

    if (myLocation.status == Status.ERROR) {
      myLocation = await _remoteDataSource.getLocation();
    }

    return myLocation;
  }

  @override
  Future<Resource<bool>> saveJadwal(MyJadwalModel myJadwal) async {
    Resource<bool> result = await _localDataSource.saveJadwal(myJadwal);
    return result;
  }

  @override
  Future<Resource<MyJadwalModel>> getJadwal(MyLocationModel myLocation) async {
    Resource<MyJadwalModel> myJadwal =
        await _localDataSource.getJadwal(myLocation);
    DateTime now = DateTime.now();
    if ((myJadwal.data?.day ?? 0) == now.day &&
        (myJadwal.data?.month ?? 0) == now.month &&
        (myJadwal.data?.year ?? 0) == now.year) {
      // DO NOTHING
    } else {
      myJadwal = await _remoteDataSource.getJadwal(myLocation);
    }

    return myJadwal;
  }
}
