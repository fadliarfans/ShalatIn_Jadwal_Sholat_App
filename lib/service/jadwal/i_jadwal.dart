import 'package:jadwal_sholat_app/data/my_jadwal_model.dart';
import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';

mixin IJadwal {
  Future<Resource<MyJadwalModel>> getJadwal(MyLocation myLocation);
}
