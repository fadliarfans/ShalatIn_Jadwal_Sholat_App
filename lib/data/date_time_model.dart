import 'package:jadwal_sholat_app/data/date_model.dart';
import 'package:jadwal_sholat_app/data/times_model.dart';

class DateTimeModel {
  TimesModel? times;
  DateModel? date;
  DateTimeModel({required this.date, required this.times});

  DateTimeModel.fromJson(Map<String, dynamic> json) {
    times = TimesModel.fromJson(json['times'] ?? "");
    date = DateModel.fromJson(json['date'] ?? "");
  }
}
