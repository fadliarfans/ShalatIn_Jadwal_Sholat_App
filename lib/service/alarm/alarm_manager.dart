// ignore_for_file: unused_field

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:jadwal_sholat_app/data/repository/repository_dart.dart';
import 'package:jadwal_sholat_app/service/alarm/alarm_adzan.dart';
import 'package:jadwal_sholat_app/service/alarm/notification/notification_manager.dart';
import 'package:jadwal_sholat_app/vo/status.dart';
import '../../data/models/shalat_model.dart';

@Injectable()
class AlarmManager {
  final AlarmAdzan _alarmAdzan;
  final Repository _repository;
  final NotificationManager _notificationManager;

  Map<Shalat, bool> myActivatedJadwal = {};

  AlarmManager(this._repository, this._alarmAdzan, this._notificationManager) {
    getActivatedJadwal();
  }

  activateAlarm(Shalat shalat) async {
    _repository.saveActivatedJadwal(shalat, true);
  }

  Future<Map<Shalat, bool>> getActivatedJadwal() async {
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

  cancelAlarm(Shalat shalat) async {
    try {
      _repository.saveActivatedJadwal(shalat, false);
      await AndroidAlarmManager.cancel(shalat.index + 100);
      await AndroidAlarmManager.cancel(shalat.index + 200);
      await AndroidAlarmManager.cancel(shalat.index + 300);
      await _notificationManager.cancelNotification(shalat.index + 400);
      debugPrint(
          "ALARM MANAGER cancelAlarm SUCCESS -----> Alarm ${shalat.name} Canceled");
    } catch (e) {
      throw Exception("ALARM MANAGER cancelAlarm ERROR -----> $e");
    }
  }
}
