import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:geocoding/geocoding.dart';
import '../../../service/city/city_manager.dart';
import '../../models/my_location_model.dart';

@Injectable()
class ApiService {
  Future<Response<dynamic>> getJadwalFromFirstApi(
      MyLocationModel myLocation) async {
    final response = await Dio().get(
        "https://api.pray.zone/v2/times/today.json?city=${myLocation.city}");
    return response;
  }

  Future<MyLocationModel> getLocation() async {
    final position = await _determinePosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    final city = await CityManager()
        .getCityByPlaceMark(placemarks.first.subAdministrativeArea ?? "");
    if (city != null) {
      final myLocation = MyLocationModel(
          city: city.cityName,
          country: placemarks.first.country,
          cityId: city.cityId);
      return myLocation;
    } else {
      throw Exception("City Not Found in Our Database");
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
