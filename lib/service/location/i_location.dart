import 'package:shared_preferences/shared_preferences.dart';

import '../../data/my_location_model.dart';
import '../../vo/resource.dart';

mixin ILocation {
  Future<Resource<MyLocationModel>> getLocation();

  Future<void> saveLocation(MyLocationModel location) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("city", location.city!);
      prefs.setString("country", location.country!);
      prefs.setString("cityId", location.cityId!);
    } catch (e) {
      rethrow;
    }
  }
}
