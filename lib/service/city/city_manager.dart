import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../data/jadwal_sholat_response/city_response.dart';

class CityManager {
  List<City>? cities;

  Future<List<City>> getCities() async {
    if (cities == null) {
      if (kDebugMode) {
        print("--> INIT CITIES");
      }
      final local = await rootBundle.loadString('assets/json/city.json');
      final data = json.decode(local);
      cities = Cities.fromJson(data).data;
      return cities ?? [];
    } else {
      return cities ?? [];
    }
  }

  Future<String?> getCityId(String city) async {
    if (cities == null) {
      await getCities();
    }
    final length = cities?.length ?? 0;
    for (int i = 0; i < length; i++) {
      if (city
          .toLowerCase()
          .contains(cities![i].cityName?.toLowerCase() ?? "")) {
        return cities![i].cityId;
      }
    }
    return null;
  }

  static final CityManager _cityManager = CityManager._internal();

  factory CityManager() {
    return _cityManager;
  }

  CityManager._internal();
}
