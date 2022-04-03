import 'package:injectable/injectable.dart';
import 'package:jadwal_sholat_app/data/models/my_jadwal_model.dart';
import 'package:jadwal_sholat_app/data/repository/remote/api_service.dart';
import '../../../vo/resource.dart';
import '../../models/jadwal_response_second_model.dart';
import '../../models/my_location_model.dart';
import '../../models/time_model.dart';

@Injectable()
class RemoteDataSource {
  final ApiService _apiService;

  RemoteDataSource(this._apiService);

  Future<Resource<MyJadwalModel>> getJadwal(MyLocationModel myLocation) async {
    try {
      final response = await _apiService.getJadwalFromFirstApi(myLocation);
      if (response.statusCode == 200) {
        final jadwal = JadwalResponseSecondModel.fromJson(response.data);
        final times = jadwal.results!.datetime!.first.times!;
        final now = DateTime.now();
        final myJadwal = MyJadwalModel(
            asr: Time(times.asr!),
            dhuhr: Time(times.dhuhr!),
            fajr: Time(times.fajr!),
            isha: Time(times.isha!),
            maghrib: Time(times.maghrib!),
            day: now.day,
            month: now.month,
            year: now.year);
        return Resource<MyJadwalModel>().success(myJadwal,
            message: "JADWAL SUCCESS ----> Get Using API");
      } else {
        return Resource<MyJadwalModel>()
            .error("JADWAL ERROR ----> ${response.statusMessage} ");
      }
    } catch (e) {
      return Resource<MyJadwalModel>().error("JADWAL ERROR ----> $e");
    }
  }

  Future<Resource<MyLocationModel>> getLocation() async {
    try {
      final myLocation = await _apiService.getLocation();
      return Resource<MyLocationModel>().success(myLocation,
          message: "LOCATION SUCCESS ----> Location From GPS = ${myLocation.city}");
    } catch (e) {
      return Resource<MyLocationModel>().error("LOCATION ERROR ----> $e");
    }
  }
}
