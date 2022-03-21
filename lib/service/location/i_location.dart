import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin ILocation {
  Future<Resource<MyLocation>> getLocation();

  Future<bool> saveToLocal(String city, String country, String cityId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("city", city);
      prefs.setString("country", country);
      prefs.setString("cityId", cityId);
      return true;
    } catch (e) {
      return false;
    }
  }
}
