import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';

abstract class ILocation {
  Future<Resource<MyLocation>> getLocation();
}
