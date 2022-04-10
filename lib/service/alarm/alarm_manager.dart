import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:jadwal_sholat_app/data/repository/repository_dart.dart';
import 'package:jadwal_sholat_app/service/alarm/alarm_service.dart';
import 'package:jadwal_sholat_app/vo/status.dart';
import '../../data/models/my_jadwal_model.dart';
import '../../data/models/shalat_model.dart';

@Injectable()
class AlarmManager {
  final Repository _repository;

  Map<Shalat, bool> myActivatedJadwal = {};

  AlarmManager(this._repository) {
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

      final resourceJadwal =
          await _repository.getLocalJadwalById(DateTime.now().day);
      MyJadwalModel? myJadwalModel = resourceJadwal.data;
      DateTime datetime = DateTime(
          myJadwalModel!.year,
          myJadwalModel.month,
          myJadwalModel.day,
          myJadwalModel.getTime(shalat).hour,
          myJadwalModel.getTime(shalat).minute);
      AlarmService.setAlarm(datetime, shalat);
      debugPrint(
          "ALARM MANAGER activeAlarm SUCCESS -----> Alarm ${shalat.name} Activated");
    } catch (e) {
      throw Exception("ALARM MANAGER activateAlarm ERROR -----> $e");
    }
  }

  cancelAlarm(Shalat shalat) async {
    try {
      _repository.saveActivatedJadwal(shalat, false);

      AlarmService.cancelAlarm(shalat);
      debugPrint(
          "ALARM MANAGER cancelAlarm SUCCESS -----> Alarm ${shalat.name} Canceled");
    } catch (e) {
      throw Exception("ALARM MANAGER cancelAlarm ERROR -----> $e");
    }
  }
}
