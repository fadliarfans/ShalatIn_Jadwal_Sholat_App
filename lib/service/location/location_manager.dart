import 'package:flutter/foundation.dart';
import 'package:jadwal_sholat_app/service/location/i_location.dart';
import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/service/location/location_local.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';

import '../../vo/status.dart';
import 'location_gps.dart';

class LocationManager {
  Future<Resource<MyLocation>> getPostition() async {
    try {
      Resource<MyLocation> resourceLocation;
      // By GPS
      ILocation location = LocationGps();
      resourceLocation = await location.getLocation();

      if (kDebugMode) {
        print("GPS Location Message : ${resourceLocation.message}");
      }

      // By Local if GPS Failed
      if (resourceLocation.status == Status.ERROR ||
          resourceLocation.status == null) {
        location = LocationLocal();
        resourceLocation = await location.getLocation();
        if (kDebugMode) {
          print("Local Location Message : ${resourceLocation.message}");
        }
      }

      if (resourceLocation.status == Status.SUCCES) {
        return resourceLocation;
      } else {
        return Resource<MyLocation>().error("Location Error");
      }
    } catch (e) {
      return Resource<MyLocation>().error("Location Error");
    }
  }
}
