import 'package:jadwal_sholat_app/data/jadwal_model.dart';

class JadwalResponse {
  int? code;
  String? status;
  JadwalModel? result;

  JadwalResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? 0;
    status = json['status'] ?? "Error";
    if (json['results'] != null) {
      result = JadwalModel.fromJson(json['results']);
    }
  }
}
