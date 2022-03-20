import 'package:dart_ipify/dart_ipify.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jadwal_sholat_app/service/location/i_location.dart';
import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/location_by_ip_model.dart';

class LocationIp with ILocation {
  @override
  Future<Resource<MyLocation>> getLocation() async {
    try {
      final ip = await Ipify.ipv4();
      final response = await Dio().get("http://ip-api.com/json/$ip");
      if (response.statusCode == 200) {
        final location = LocationByIpModel.fromJson(response.data);
        final myLocation = MyLocation(
            alt: 0,
            city: location.city,
            country: location.country,
            lat: location.lat,
            long: location.lon);
        if (kDebugMode) {
          print(location.country);
          print(location.city);
          print(location.lat);
          print(location.lon);
        }
        try {
          final prefs = await SharedPreferences.getInstance();
          final bool isFromGPS = prefs.getBool("isFromGPS") ?? false;
          if (isFromGPS == false) {
            super.saveToLocal(location.lat ?? 0.0, 0.0, location.lon ?? 0.0,
                location.city ?? "", location.country ?? "", false);
            if (kDebugMode) {
              print("Location IP Save To Local");
            }
          }
        } catch (e) {
          return Resource<MyLocation>().error("Local Error");
        }
        return Resource<MyLocation>().success(myLocation);
      } else {
        return Resource<MyLocation>().error("Internet Error");
      }
    } catch (e) {
      return Resource<MyLocation>().error(e.toString());
    }
  }
}
