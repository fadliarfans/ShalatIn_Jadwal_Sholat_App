import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jadwal_sholat_app/service/location/i_location.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';
import 'package:jadwal_sholat_app/data/my_location_model.dart';

class LocationGps extends ILocation {
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
      final myLocation = MyLocation(
          alt: position.altitude,
          city: placemarks.first.locality,
          country: placemarks.first.country,
          lat: position.latitude,
          long: position.longitude);
      if (kDebugMode) {
        print("Country   : ${myLocation.country}");
        print("City      : ${myLocation.city}");
        print("Latitude  : ${myLocation.lat}");
        print("Longitude : ${myLocation.long}");
        print("Altitude  : ${myLocation.alt}");
      }

      return Resource<MyLocation>().success(myLocation);
    } catch (e) {
      return Resource<MyLocation>().error(e.toString());
    }
  }
}
