import 'i_location.dart';
import '../../data/my_location_model.dart';
import '../../vo/resource.dart';

class LocationManager {
  ILocation _iLocation;
  LocationManager(this._iLocation);

  setILocation(ILocation iLocation) {
    _iLocation = iLocation;
  }

  Future<void> saveLocation(MyLocationModel location) async {
    _iLocation.saveLocation(location);
  }

  Future<Resource<MyLocationModel>> getLocation() async {
    return _iLocation.getLocation();
  }
}
