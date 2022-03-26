import 'i_location.dart';
import '../../data/my_location_model.dart';
import '../../vo/resource.dart';

class LocationManager {
  ILocation _iLocation;
  LocationManager(this._iLocation);

  setILocation(ILocation iLocation) {
    _iLocation = iLocation;
  }

  Future<void> saveLocation(String city, String country, String cityId) async {
    _iLocation.saveLocation(city, country, cityId);
  }

  Future<Resource<MyLocationModel>> getLocation() async {
    return _iLocation.getLocation();
  }
}
