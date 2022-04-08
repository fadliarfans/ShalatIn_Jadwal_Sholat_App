import 'package:injectable/injectable.dart';
import 'package:jadwal_sholat_app/data/models/jadwal_response.dart';
import 'package:jadwal_sholat_app/data/models/my_jadwal_model.dart';
import 'package:jadwal_sholat_app/data/repository/remote/api_service.dart';
import '../../../vo/resource.dart';
import '../../models/my_location_model.dart';
import '../../models/time_model.dart';

@Injectable()
class RemoteDataSource {
  final ApiService _apiService;

  RemoteDataSource(this._apiService);

  Future<Resource<List<MyJadwalModel>>> getJadwal(
      MyLocationModel myLocation) async {
    try {
      final response = await _apiService.getJadwalFromFirstApi(myLocation);
      if (response.statusCode == 200) {
        final jadwal = Jadwalresponse.fromJson(response.data);
        final listJadwal = jadwal.data!.jadwal;
        final myJadwal = listJadwal
            ?.map((jadwal) => MyJadwalModel(
                asr: Time(jadwal.ashar!),
                dhuhr: Time(jadwal.dzuhur!),
                fajr: Time(jadwal.subuh!),
                isha: Time(jadwal.isya!),
                maghrib: Time(jadwal.maghrib!),
                day: int.parse(jadwal.date!.substring(8, 10)),
                month: int.parse(jadwal.date!.substring(5, 7)),
                year: int.parse(jadwal.date!.substring(0, 4))))
            .toList();
        return Resource<List<MyJadwalModel>>()
            .success(myJadwal!, message: "JADWAL SUCCESS ----> Get Using API");
      } else {
        return Resource<List<MyJadwalModel>>()
            .error("JADWAL ERROR ----> ${response.statusMessage} ");
      }
    } catch (e) {
      return Resource<List<MyJadwalModel>>().error("JADWAL ERROR ----> $e");
    }
  }

  Future<Resource<MyLocationModel>> getLocation() async {
    try {
      final myLocation = await _apiService.getLocation();
      return Resource<MyLocationModel>().success(myLocation,
          message:
              "LOCATION SUCCESS ----> Location From GPS = ${myLocation.city}");
    } catch (e) {
      return Resource<MyLocationModel>().error("LOCATION ERROR ----> $e");
    }
  }
}
