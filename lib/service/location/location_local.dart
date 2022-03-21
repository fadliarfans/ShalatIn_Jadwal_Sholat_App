import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/service/location/i_location.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationLocal with ILocation {
  @override
  Future<Resource<MyLocation>> getLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final city = prefs.getString("city");
      final country = prefs.getString("country");
      final cityId = prefs.getString("cityId");
      final myLocation =
          MyLocation(city: city, country: country, cityId: cityId);
      return Resource<MyLocation>().success(myLocation);
    } catch (e) {
      return Resource<MyLocation>().error(e.toString());
    }
  }
}
