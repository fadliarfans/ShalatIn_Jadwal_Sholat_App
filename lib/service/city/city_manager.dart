import 'dart:convert';

import 'package:flutter/services.dart';

import '../../data/models/city_model.dart';

class CityManager {
  List<City>? cities;

  Future<List<City>> getCities() async {
    if (cities == null) {
      final local = await rootBundle.loadString('assets/json/city.json');
      List<dynamic> data = json.decode(local);
      cities = data.map((e) => City.fromJson(e)).toList();

      return cities ?? [];
    } else {
      return cities ?? [];
    }
  }

  Future<City?> getCityByPlaceMark(String city) async {
    if (cities == null) {
      await getCities();
    }
    final length = cities?.length ?? 0;
    for (int i = 0; i < length; i++) {
      if (city.toLowerCase().contains(cities![i].lokasi?.toLowerCase() ?? "")) {
        return cities![i];
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
