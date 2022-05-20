import 'dart:developer' as developer;
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jadwal_sholat_app/service/notification/notification_manager.dart';
import 'package:jadwal_sholat_app/util/get_day_in_month.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_ios/path_provider_ios.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_ios/shared_preferences_ios.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';

import '../../data/models/jadwal_response.dart';
import '../../data/models/my_jadwal_model.dart';
import '../../data/models/shalat_model.dart';
import '../../data/models/time_model.dart';

@Injectable()
class AlarmService {
  static Future<void> _callbackSubuh() async {
    developer.log('Alarm fired!');
    try {
      if (Platform.isAndroid) PathProviderAndroid.registerWith();
      if (Platform.isIOS) PathProviderIOS.registerWith();
      // AudioCache audioPlayer = AudioCache();
      // audioPlayer.play("audio/Adzan-Misyari-Rasyid.mp3");
      NotificationManager _notificationManager = NotificationManager();
      await _notificationManager.init();
      await _notificationManager.showNotificationSubuh();
    } catch (e) {
      developer.log(e.toString());
    }
  }

  static Future<void> _callbackDzuhur() async {
    developer.log('Alarm fired!');
    try {
      if (Platform.isAndroid) PathProviderAndroid.registerWith();
      if (Platform.isIOS) PathProviderIOS.registerWith();
      // AudioCache audioPlayer = AudioCache();
      // audioPlayer.play("audio/Adzan-Misyari-Rasyid.mp3");
      NotificationManager _notificationManager = NotificationManager();
      await _notificationManager.init();
      await _notificationManager.showNotificationDzuhur();
    } catch (e) {
      developer.log(e.toString());
    }
  }

  static Future<void> _callbackAshar() async {
    developer.log('Alarm fired!');
    try {
      if (Platform.isAndroid) PathProviderAndroid.registerWith();
      if (Platform.isIOS) PathProviderIOS.registerWith();
      // AudioCache audioPlayer = AudioCache();
      // audioPlayer.play("audio/Adzan-Misyari-Rasyid.mp3");
      NotificationManager _notificationManager = NotificationManager();
      await _notificationManager.init();
      await _notificationManager.showNotificationAshar();
    } catch (e) {
      developer.log(e.toString());
    }
  }

  static Future<void> _callbackMaghrib() async {
    developer.log('Alarm fired!');
    try {
      if (Platform.isAndroid) PathProviderAndroid.registerWith();
      if (Platform.isIOS) PathProviderIOS.registerWith();
      // AudioCache audioPlayer = AudioCache();
      // audioPlayer.play("audio/Adzan-Misyari-Rasyid.mp3");
      NotificationManager _notificationManager = NotificationManager();
      await _notificationManager.init();
      await _notificationManager.showNotificationMaghrib();
    } catch (e) {
      developer.log(e.toString());
    }
  }

  static Future<void> _callbackIsya() async {
    developer.log('Alarm fired!');
    try {
      if (Platform.isAndroid) PathProviderAndroid.registerWith();
      if (Platform.isIOS) PathProviderIOS.registerWith();
      // AudioCache audioPlayer = AudioCache();
      // audioPlayer.play("audio/Adzan-Misyari-Rasyid.mp3");
      NotificationManager _notificationManager = NotificationManager();
      await _notificationManager.init();
      await _notificationManager.showNotificationIsya();
    } catch (e) {
      developer.log(e.toString());
    }
  }

  Future<void> setAlarm(DateTime trueDate, Shalat shalat, int id) async {
    developer.log("ALARM MESSAGE -----> Alarm Will run at $trueDate");
    switch (shalat) {
      case Shalat.Subuh:
        await AndroidAlarmManager.oneShotAt(trueDate, id, _callbackSubuh,
            allowWhileIdle: true,
            alarmClock: true,
            rescheduleOnReboot: false,
            wakeup: true);
        break;
      case Shalat.Dzuhur:
        await AndroidAlarmManager.oneShotAt(trueDate, id, _callbackDzuhur,
            allowWhileIdle: true,
            alarmClock: true,
            rescheduleOnReboot: false,
            wakeup: true);
        break;
      case Shalat.Ashar:
        await AndroidAlarmManager.oneShotAt(trueDate, id, _callbackAshar,
            allowWhileIdle: true,
            alarmClock: true,
            rescheduleOnReboot: false,
            wakeup: true);
        break;
      case Shalat.Maghrib:
        await AndroidAlarmManager.oneShotAt(trueDate, id, _callbackMaghrib,
            allowWhileIdle: true,
            alarmClock: true,
            rescheduleOnReboot: false,
            wakeup: true);
        break;
      case Shalat.Isya:
        await AndroidAlarmManager.oneShotAt(trueDate, id, _callbackIsya,
            allowWhileIdle: true,
            alarmClock: true,
            rescheduleOnReboot: false,
            wakeup: true);
        break;
    }
  }

  Future<void> cancelAlarm(Shalat shalat, int id) async {
    try {
      await AndroidAlarmManager.cancel(id);
    } catch (e) {
      rethrow;
    }
  }

  static activateJadwalMonthlyInBackgroundSYNC(
      List<MyJadwalModel> listMyJadwalModel,
      bool subuh,
      bool dzuhur,
      bool ashar,
      bool maghrib,
      bool isya) async {
    final dayInMonth = getDayInMonth();
    for (int i = 0; i < dayInMonth; i++) {
      if (subuh) {
        DateTime trueDate = DateTime(
            listMyJadwalModel[i].year,
            listMyJadwalModel[i].month,
            listMyJadwalModel[i].day,
            listMyJadwalModel[i].getTime(Shalat.Subuh).hour,
            listMyJadwalModel[i].getTime(Shalat.Subuh).minute);
        int id = i * 100 + Shalat.Subuh.index * 10000;
        await AndroidAlarmManager.oneShotAt(trueDate, id, _callbackSubuh,
            exact: true, rescheduleOnReboot: false, wakeup: true);
      }
      if (dzuhur) {
        DateTime trueDate = DateTime(
            listMyJadwalModel[i].year,
            listMyJadwalModel[i].month,
            listMyJadwalModel[i].day,
            listMyJadwalModel[i].getTime(Shalat.Dzuhur).hour,
            listMyJadwalModel[i].getTime(Shalat.Dzuhur).minute);
        int id = i * 100 + Shalat.Dzuhur.index * 10000;
        await AndroidAlarmManager.oneShotAt(trueDate, id, _callbackDzuhur,
            exact: true, rescheduleOnReboot: false, wakeup: true);
      }
      if (ashar) {
        DateTime trueDate = DateTime(
            listMyJadwalModel[i].year,
            listMyJadwalModel[i].month,
            listMyJadwalModel[i].day,
            listMyJadwalModel[i].getTime(Shalat.Ashar).hour,
            listMyJadwalModel[i].getTime(Shalat.Ashar).minute);
        int id = i * 100 + Shalat.Ashar.index * 10000;
        await AndroidAlarmManager.oneShotAt(trueDate, id, _callbackAshar,
            exact: true, rescheduleOnReboot: false, wakeup: true);
      }
      if (maghrib) {
        DateTime trueDate = DateTime(
            listMyJadwalModel[i].year,
            listMyJadwalModel[i].month,
            listMyJadwalModel[i].day,
            listMyJadwalModel[i].getTime(Shalat.Maghrib).hour,
            listMyJadwalModel[i].getTime(Shalat.Maghrib).minute);
        int id = i * 100 + Shalat.Maghrib.index * 10000;
        await AndroidAlarmManager.oneShotAt(trueDate, id, _callbackMaghrib,
            exact: true, rescheduleOnReboot: false, wakeup: true);
      }
      if (isya) {
        DateTime trueDate = DateTime(
            listMyJadwalModel[i].year,
            listMyJadwalModel[i].month,
            listMyJadwalModel[i].day,
            listMyJadwalModel[i].getTime(Shalat.Isya).hour,
            listMyJadwalModel[i].getTime(Shalat.Isya).minute);
        int id = i * 100 + Shalat.Isya.index * 10000;
        await AndroidAlarmManager.oneShotAt(trueDate, id, _callbackIsya,
            exact: true, rescheduleOnReboot: false, wakeup: true);
      }
    }
  }

  static backgroundSYNC() async {
    if (Platform.isAndroid) {
      PathProviderAndroid.registerWith();
      SharedPreferencesAndroid.registerWith();
    }
    if (Platform.isIOS) {
      PathProviderIOS.registerWith();
      SharedPreferencesIOS.registerWith();
    }
    final prefs = await SharedPreferences.getInstance();
    try {
      developer.log('Alarm fired! -----> callbackUpdateJadwal()');

      // Get data from internet using API
      final now = DateTime.now();
      prefs.reload();
      final cityId = prefs.getString("cityId");
      final response = await Dio().get(
          "https://api.myquran.com/v1/sholat/jadwal/$cityId/${now.year}/${now.month.toString().padLeft(2, "0")}");
      if (response.statusCode == 200) {
        final jadwal = Jadwalresponse.fromJson(response.data);
        final listJadwal = jadwal.data!.jadwal;
        final myJadwal = listJadwal
                ?.map((jadwal) => MyJadwalModel(
                    asr: Time(jadwal.ashar!),
                    dhuhr: Time(jadwal.dzuhur!),
                    fajr: Time(jadwal.subuh!),
                    isha: Time(jadwal.isya!),
                    maghrib: Time(jadwal.maghrib!),
                    day: int.parse(jadwal.date!.substring(8, 10)),
                    month: int.parse(jadwal.date!.substring(5, 7)),
                    year: int.parse(jadwal.date!.substring(0, 4))))
                .toList() ??
            [];
        developer.log("SUCCES Get Jadwal From API");

        // Activate Jadwal Alarm
        final subuh = prefs.getBool("${Shalat.Subuh.name} Activated") ?? false;
        final dzuhur =
            prefs.getBool("${Shalat.Dzuhur.name} Activated") ?? false;
        final ashar = prefs.getBool("${Shalat.Ashar.name} Activated") ?? false;
        final maghrib =
            prefs.getBool("${Shalat.Maghrib.name} Activated") ?? false;
        final isya = prefs.getBool("${Shalat.Isya.name} Activated") ?? false;
        activateJadwalMonthlyInBackgroundSYNC(
            myJadwal, subuh, dzuhur, ashar, maghrib, isya);
        developer.log("SUCCES Activate Jadwal Alarm");

        // Background SYNC SUCCESS
        developer.log("BACKGROUND SYNC SUCCESS");
        prefs.setBool("Background_SYNC", true);
      } else {
        // Background SYNC Failed Because Internet Error
        developer
            .log("BACKGROUND SYNC ERROR ----> failed get Data from internet");
        prefs.setBool("Background_SYNC", false);
      }
    } catch (e) {
      // Background SYNC Failed
      developer.log("BACKGROUND SYNC ERROR ----> $e");
      prefs.setBool("Background_SYNC", false);
    }
  }

  Future<void> launchUpdateJadwalNextMonth() async {
    try {
      final now = DateTime.now();
      var month = now.month;
      var year = now.year;
      if (month == 12) {
        month = 1;
        year++;
      } else {
        month++;
      }

      final nextMonth = DateTime(year, month, 1);
      await AndroidAlarmManager.cancel(150302);
      await AndroidAlarmManager.oneShotAt(nextMonth, 150302, backgroundSYNC,
          rescheduleOnReboot: true, allowWhileIdle: true);
      developer.log(
          'Launch Alarm next Month Jadwal! -----> ${nextMonth.toString()}');
    } catch (e) {
      rethrow;
    }
  }
}
