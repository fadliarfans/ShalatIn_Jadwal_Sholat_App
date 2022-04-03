import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../injection.dart';
import '../../../vo/resource.dart';
import '../../models/my_location_model.dart';

@Injectable()
class LocationDao {
  Future<void> saveLocation(MyLocationModel location) async {
    final prefs = await locator<SharedPreferences>();
    prefs.setString("city", location.city!);
    prefs.setString("country", location.country!);
    prefs.setString("cityId", location.cityId!);
  }

  Future<MyLocationModel> getLocation() async {
    final prefs = await locator<SharedPreferences>();
    final city = prefs.getString("city");
    final country = prefs.getString("country");
    final cityId = prefs.getString("cityId");
    if (city == null || country == null || cityId == null) {
      throw Exception("Location local not found");
    } else {
      return MyLocationModel(city: city, country: country, cityId: cityId);
    }
  }
}
