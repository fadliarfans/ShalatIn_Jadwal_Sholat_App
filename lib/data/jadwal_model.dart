import 'package:jadwal_sholat_app/data/date_time_model.dart';
import 'package:jadwal_sholat_app/data/location_model.dart';
import 'package:jadwal_sholat_app/data/settings_model.dart';

class JadwalModel {
  List<DateTimeModel>? listDateTime;
  LocationModel? location;
  SettingsModel? settings;
  JadwalModel(
      {required this.listDateTime,
      required this.location,
      required this.settings});

  JadwalModel.fromJson(Map<String, dynamic> json) {
    if (json['datetime'] != null) {
      listDateTime = <DateTimeModel>[];
      json['datetime'].foreach((v) {
        listDateTime?.add(DateTimeModel.fromJson(v));
      });
    }
    if (json['location'] != null) {
      location = LocationModel.fromJson(json['location']);
    }
    if (json['settings'] != null) {
      settings = SettingsModel.fromJson(json['settings']);
    }
  }
}
