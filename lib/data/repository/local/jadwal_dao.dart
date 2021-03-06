import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:jadwal_sholat_app/data/models/my_jadwal_entity.dart';
import 'package:jadwal_sholat_app/injection.dart';
import 'package:jadwal_sholat_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/my_jadwal_model.dart';
import '../../models/my_location_model.dart';
import '../../models/shalat_model.dart';

@Injectable()
class JadwalDao {
  Future<void> saveActivatedJadwal(Shalat shalat, bool value) async {
    final prefs = locator<SharedPreferences>();
    prefs.setBool("${shalat.name} Activated", value);
  }

  Future<Map<Shalat, bool>> getActivatedJadwal() async {
    final prefs = locator<SharedPreferences>();
    final subuh = prefs.getBool("${Shalat.Subuh.name} Activated") ?? false;
    final dzuhur = prefs.getBool("${Shalat.Dzuhur.name} Activated") ?? false;
    final ashar = prefs.getBool("${Shalat.Ashar.name} Activated") ?? false;
    final maghrib = prefs.getBool("${Shalat.Maghrib.name} Activated") ?? false;
    final isya = prefs.getBool("${Shalat.Isya.name} Activated") ?? false;
    return {
      Shalat.Subuh: subuh,
      Shalat.Dzuhur: dzuhur,
      Shalat.Ashar: ashar,
      Shalat.Maghrib: maghrib,
      Shalat.Isya: isya
    };
  }

  Future<void> saveJadwal(List<MyJadwalModel> jadwal) async {
    final jadwalBox = objectbox!.store.box<MyJadwalEntity>();
    jadwalBox.removeAll();
    for (int i = 0; i < jadwal.length; i++) {
      jadwalBox.put(jadwal[i].toMyJadwalEntity());
    }
  }

  Future<List<MyJadwalModel>> getJadwal(MyLocationModel myLocation) async {
    final prefs = locator<SharedPreferences>();
    final city = prefs.getString("cityId");
    final backgroundSYNC = prefs.getBool("Background_SYNC") ?? false;
    debugPrint(
        "Background SYNC at First day in this month :  ${backgroundSYNC.toString()}");
    if (city == myLocation.cityId) {
      final jadwalBox = objectbox!.store.box<MyJadwalEntity>();

      List<MyJadwalModel> myJadwalList =
          jadwalBox.getAll().map((e) => e.toMyJadwalModel()).toList();
      if (myJadwalList.isEmpty) {
        throw Exception("Jadwal from Local Empty !");
      }
      if (myJadwalList.first.month != DateTime.now().month) {
        throw Exception("Month Different !");
      }
      return myJadwalList;
    } else {
      throw Exception("City Different !");
    }
  }

  Future<List<MyJadwalModel>> getJadwalWithoutLocation() async {
    final jadwalBox = objectbox!.store.box<MyJadwalEntity>();

    List<MyJadwalModel> myJadwalList =
        jadwalBox.getAll().map((e) => e.toMyJadwalModel()).toList();
    if (myJadwalList.isEmpty) {
      throw Exception("Jadwal from Local Empty !");
    }
    return myJadwalList;
  }

  Future<MyJadwalModel> getJadwalById(int id) async {
    final jadwalBox = objectbox!.store.box<MyJadwalEntity>();

    MyJadwalModel myJadwalModel = jadwalBox.get(id)!.toMyJadwalModel();
    return myJadwalModel;
  }
}
