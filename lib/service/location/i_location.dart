import 'package:shared_preferences/shared_preferences.dart';

import '../../data/my_location_model.dart';
import '../../vo/resource.dart';

mixin ILocation {
  Future<Resource<MyLocationModel>> getLocation();

  Future<void> saveLocation(String city, String country, String cityId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("city", city);
      prefs.setString("country", country);
      prefs.setString("cityId", cityId);
    } catch (e) {
      rethrow;
    }
  }
}
