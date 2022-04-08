import 'package:injectable/injectable.dart';
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
    final jadwalBox = objectbox.store.box<MyJadwalModel>();
    jadwalBox.removeAll();
    for (int i = 0; i < jadwal.length; i++) {
      jadwalBox.put(jadwal[i]);
    }
  }

  Future<List<MyJadwalModel>> getJadwal(MyLocationModel myLocation) async {
    final prefs = locator<SharedPreferences>();
    final city = prefs.getString("cityId");
    if (city == myLocation.cityId) {
      final jadwalBox = objectbox.store.box<MyJadwalModel>();
      final myJadwalList = jadwalBox.getAll();
      return myJadwalList;
    } else {
      throw Exception("City Different !");
    }
  }
}
