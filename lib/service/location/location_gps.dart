import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jadwal_sholat_app/service/city/city_manager.dart';
import 'package:jadwal_sholat_app/service/location/i_location.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';
import 'package:jadwal_sholat_app/data/my_location_model.dart';

class LocationGps with ILocation {
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

  @override
  Future<Resource<MyLocation>> getLocation() async {
    try {
      final position = await _determinePosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final cityId = await CityManager()
          .getCityId(placemarks.first.subAdministrativeArea ?? "");
      final myLocation = MyLocation(
          city: placemarks.first.subAdministrativeArea,
          country: placemarks.first.country,
          cityId: cityId);
      if (kDebugMode) {
        print("Country   : ${myLocation.country}");
        print("City      : ${myLocation.city}");
        print("City Id   : ${myLocation.cityId}");
      }
      try {
        super.saveToLocal(myLocation.city ?? "", myLocation.country ?? "",
            myLocation.cityId ?? "");
        if (kDebugMode) {
          print("Location GPS Save To Local");
        }
      } catch (e) {
        return Resource<MyLocation>().error("Save To Local Error");
      }

      return Resource<MyLocation>().success(myLocation);
    } catch (e) {
      return Resource<MyLocation>().error(e.toString());
    }
  }
}
