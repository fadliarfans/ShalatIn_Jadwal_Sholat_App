import 'package:flutter/foundation.dart';
import 'package:jadwal_sholat_app/data/my_jadwal_model.dart';
import 'package:jadwal_sholat_app/service/jadwal/jadwal_coordinate.dart';
import 'package:jadwal_sholat_app/service/jadwal/jadwal_local.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';
import 'package:jadwal_sholat_app/vo/status.dart';

import '../../data/my_location_model.dart';

class JadwalManager {
  Future<Resource<MyJadwalModel>> getJadwal(MyLocation location) async {
    try {
      Resource<MyJadwalModel> resourceJadwal;

      resourceJadwal = await JadwalCoordinate().getJadwal(location);
      if (kDebugMode) {
        print("Jadwal from API Status : ${resourceJadwal.message}");
      }

      if (resourceJadwal.status == Status.ERROR) {
        resourceJadwal = await JadwalLocal().getJadwal(location);
        if (kDebugMode) {
          print("Jadwal from Local Status : ${resourceJadwal.message}");
        }
      }

      if (resourceJadwal.status == Status.SUCCES) {
        return resourceJadwal;
      } else {
        return Resource<MyJadwalModel>()
            .error(resourceJadwal.message ?? "Jadwal Error");
      }
    } catch (e) {
      return Resource<MyJadwalModel>().error(e.toString());
    }
  }
}
