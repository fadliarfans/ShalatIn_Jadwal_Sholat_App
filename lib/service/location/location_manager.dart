import 'package:jadwal_sholat_app/service/location/i_location.dart';
import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';

class LocationManager {
  final ILocation iLocation;
  LocationManager(this.iLocation);

  Future<Resource<MyLocation>> getPostition() async {
    return iLocation.getLocation();
  }
}
