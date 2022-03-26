import '../../data/my_location_model.dart';
import 'i_location.dart';
import '../../vo/resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationLocal with ILocation {
  @override
  Future<Resource<MyLocationModel>> getLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final city = prefs.getString("city");
      final country = prefs.getString("country");
      final cityId = prefs.getString("cityId");
      if (city == null || country == null || cityId == null) {
        return Resource<MyLocationModel>()
            .error("LOCATION ERROR ----> Location local not found");
      } else {
        final myLocation =
            MyLocationModel(city: city, country: country, cityId: cityId);
        return Resource<MyLocationModel>().success(myLocation,
            message: "LOCATION SUCCESS ----> Location From Local");
      }
    } catch (e) {
      return Resource<MyLocationModel>()
          .error("LOCATION ERROR ----> ${e.toString()}");
    }
  }
}
