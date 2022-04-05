import 'dart:math';

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

    await activateTodayAlarm(shalat);
    await activateTommorowAlarm(shalat);
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

  activateTommorowAlarm(Shalat shalat) async {
    try {
      DateTime now = DateTime.now();
      await AndroidAlarmManager.oneShotAt(
          DateTime(
            now.year, now.month, now.day, 1,
            //  Random().nextInt(60),
            //         Random().nextInt(60)
          ).add(const Duration(days: 1)),
          shalat.index + 100, () {
        debugPrint("Tommorow shot");
        AndroidAlarmManager.periodic(
            const Duration(hours: 24), shalat.index + 200, () async {
          final times = await _getTimeLocal(shalat);
          debugPrint("Tommorow Next shot");
          //iAlarm.playAdzan(await _getTime(shalatStatic), shalatStatic.index + 300);
          _notificationManager.setZonedScheduleNotification(
              times.hour, times.minute, shalat);
        });
      });
    } catch (e) {
      debugPrint("ERROR ----> $e");
    }
  }

  activateTodayAlarm(Shalat shalat) async {
    try {
      DateTime now = DateTime.now();
      final times = await _getTimeLocal(shalat);
      if (now.hour > times.hour) {
        return;
      }

      if (now.hour == times.hour) {
        if (now.minute > times.minute) {
          return;
        }
      }

      //_alarmAdzan.playAdzan(times, shalat.index + 300);
      _notificationManager.setZonedScheduleNotification(
          times.hour, times.minute, shalat);
      debugPrint(
          "ALARM MANAGER activateTodayAlarm SUCCESS -----> Alarm Succes Activated : Alarm ${shalat.name} Will Fired At ${times.hour}:${times.minute}");
    } catch (e) {
      throw Exception("ALARM MANAGER activateTodayAlarm ERROR -----> $e");
    }
  }

  // NOTE : GET TODAY ALARM SHALAT
  Future<DateTime> _getTimeLocal(Shalat shalat) async {
    try {
      final resourceLocation = await _repository.getLocation();

      final resourceJadwal =
          await _repository.getJadwal(resourceLocation.data!);

      if (resourceJadwal.status == Status.SUCCES) {
        final times = resourceJadwal.data!;
        _repository.saveJadwal(times);
        DateTime now = DateTime.now();
        final hour = times.getTime(shalat).hour;
        final minute = times.getTime(shalat).minute;
        debugPrint("ALARM MANAGER getTimeLocal SUCCESS -----> Get Today Times");
        return DateTime(now.year, now.month, now.day, hour, minute);
      } else {
        throw Exception(
            "ALARM MANAGER getTimeLocal ERROR -----> Failed Get Jadwal");
      }
    } catch (e) {
      throw Exception("ALARM MANAGER getTimeLocal ERROR -----> $e");
    }
  }
}
