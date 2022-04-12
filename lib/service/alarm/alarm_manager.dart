import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:jadwal_sholat_app/data/repository/repository_dart.dart';
import 'package:jadwal_sholat_app/service/alarm/alarm_service.dart';
import 'package:jadwal_sholat_app/util/get_day_in_month.dart';
import 'package:jadwal_sholat_app/vo/status.dart';
import '../../data/models/my_jadwal_model.dart';
import '../../data/models/shalat_model.dart';

@Injectable()
class AlarmManager {
  final Repository _repository;
  final AlarmService _alarmService;

  Map<Shalat, bool> myActivatedJadwal = {};

  AlarmManager(this._repository, this._alarmService) {
    getAllActivatedJadwal();
  }

  Future<Map<Shalat, bool>> getAllActivatedJadwal() async {
    try {
      final resource = await _repository.getActivatedJadwal();
      if (resource.status == Status.SUCCES) {
        myActivatedJadwal = resource.data!;
        return myActivatedJadwal;
      } else {
        throw Exception(
            "ALARM MANAGER getActivatedJadwal -----> Activated Jadwal Failed To Get");
      }
    } catch (e) {
      throw Exception("ALARM MANAGER getActivatedJadwal-----> $e");
    }
  }

  activateAlarm(Shalat shalat) async {
    try {
      _repository.saveActivatedJadwal(shalat, true);

      final resourceJadwal = await _repository.getJadwalLocal();
      List<MyJadwalModel> listMyJadwalModel = resourceJadwal.data!;
      final dayInMonth = getDayInMonth();
      final currDay = DateTime.now().day;

      for (int i = currDay - 1; i <= dayInMonth - 1; i++) {
        DateTime date = DateTime(
            listMyJadwalModel[i].year,
            listMyJadwalModel[i].month,
            listMyJadwalModel[i].day,
            listMyJadwalModel[i].getTime(shalat).hour,
            listMyJadwalModel[i].getTime(shalat).minute);
        int id = i * 100 + shalat.index * 10000;
        _alarmService.setAlarm(date, shalat, id);
      }

      debugPrint(
          "ALARM MANAGER activeAlarm SUCCESS -----> Alarm ${shalat.name} Actived");
    } catch (e) {
      throw Exception("ALARM MANAGER activateAlarm ERROR -----> $e");
    }
  }

  cancelAlarm(Shalat shalat) async {
    try {
      _repository.saveActivatedJadwal(shalat, false);
      final dayInMonth = getDayInMonth();
      final currDay = DateTime.now().day;

      for (int i = currDay - 1; i <= dayInMonth - 1; i++) {
        int id = i * 100 + shalat.index * 10000;
        _alarmService.cancelAlarm(shalat, id);
      }

      debugPrint(
          "ALARM MANAGER cancelAlarm SUCCESS -----> Alarm ${shalat.name} Canceled");
    } catch (e) {
      throw Exception("ALARM MANAGER cancelAlarm ERROR -----> $e");
    }
  }

  monthlyAlarm() {
    try {} catch (e) {}
  }
}
