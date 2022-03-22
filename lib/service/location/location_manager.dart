import 'package:flutter/foundation.dart';
import 'package:jadwal_sholat_app/service/location/i_location.dart';
import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/service/location/location_local.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../vo/status.dart';
import 'location_gps.dart';

class LocationManager {
  Future<void> savePosition(String city, String country, String cityId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("city", city);
      prefs.setString("country", country);
      prefs.setString("cityId", cityId);
    } catch (e) {
      rethrow;
    }
  }

  Future<Resource<MyLocation>> getPostition() async {
    try {
      Resource<MyLocation> resourceLocation;
      // By GPS
      ILocation location = LocationGps();
      resourceLocation = await location.getLocation();

      if (kDebugMode) {
        print("GPS Location Message : ${resourceLocation.message}");
      }

      // IF Get Location from GPS Failed -> get from local
      if (resourceLocation.status == Status.ERROR ||
          resourceLocation.status == null) {
        location = LocationLocal();
        resourceLocation = await location.getLocation();
        if (kDebugMode) {
          print("Local Location Message : ${resourceLocation.message}");
        }
      } else {
        // IF Get Location from GPS Succes -> Save Location
        final data = resourceLocation.data!;
        savePosition(data.city!, data.country!, data.cityId!);
      }

      if (resourceLocation.status == Status.SUCCES) {
        return resourceLocation;
      } else {
        return Resource<MyLocation>().error("Location Error");
      }
    } catch (e) {
      return Resource<MyLocation>().error(e.toString());
    }
  }
}
