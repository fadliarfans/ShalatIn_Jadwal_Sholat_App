import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/service/location/i_location.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationLocal with ILocation {
  @override
  Future<Resource<MyLocation>> getLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lat = prefs.getDouble("lat");
      final alt = prefs.getDouble("alt");
      final lon = prefs.getDouble("lon");
      final city = prefs.getString("city");
      final country = prefs.getString("country");
      final myLocation = MyLocation(
          alt: alt, city: city, country: country, lat: lat, long: lon);
      return Resource<MyLocation>().success(myLocation);
    } catch (e) {
      return Resource<MyLocation>().error(e.toString());
    }
  }
}
