import 'package:injectable/injectable.dart';

import '../../../../vo/resource.dart';
import '../../../models/my_jadwal_model.dart';
import '../../../models/my_location_model.dart';
import 'cache.dart';

@Injectable()
class LocationDao {
  final Cache _cache;

  LocationDao(this._cache);

  Future<void> saveLocation(MyLocationModel location) async {
    final prefs = _cache.pref;
    prefs.setString("city", location.city!);
    prefs.setString("country", location.country!);
    prefs.setString("cityId", location.cityId!);
  }

  Future<MyLocationModel> getLocation() async {
    final prefs = _cache.pref;
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
