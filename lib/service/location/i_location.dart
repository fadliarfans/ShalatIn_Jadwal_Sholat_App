import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin ILocation {
  Future<Resource<MyLocation>> getLocation();

  Future<bool> saveToLocal(
      double lat, double alt, double lon, String city, String country) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setDouble("lat", lat);
      prefs.setDouble("alt", alt);
      prefs.setDouble("lon", lon);
      prefs.setString("city", city);
      prefs.setString("country", country);
      return true;
    } catch (e) {
      return false;
    }
  }
}
