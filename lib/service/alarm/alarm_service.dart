import 'dart:developer' as developer;
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jadwal_sholat_app/service/notification/notification_manager.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_ios/path_provider_ios.dart';

import '../../data/models/shalat_model.dart';

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
      debugPrint(e.toString());
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
      debugPrint(e.toString());
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
      debugPrint(e.toString());
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
      debugPrint(e.toString());
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
      debugPrint(e.toString());
    }
  }

  Future<void> setAlarm(DateTime date, Shalat shalat, int id) async {
    DateTime trueDate = date;
    if (date.isBefore(DateTime.now())) {
      trueDate = trueDate.add(const Duration(days: 1));
    }
    developer.log("ALARM MESSAGE -----> Alarm Will run at $trueDate");
    switch (shalat) {
      case Shalat.Subuh:
        await AndroidAlarmManager.oneShotAt(trueDate, id, _callbackSubuh,
            alarmClock: true, rescheduleOnReboot: false, wakeup: true);
        break;
      case Shalat.Dzuhur:
        await AndroidAlarmManager.oneShotAt(trueDate, id, _callbackDzuhur,
            alarmClock: true, rescheduleOnReboot: false, wakeup: true);
        break;
      case Shalat.Ashar:
        await AndroidAlarmManager.oneShotAt(trueDate, id, _callbackAshar,
            alarmClock: true, rescheduleOnReboot: false, wakeup: true);
        break;
      case Shalat.Maghrib:
        await AndroidAlarmManager.oneShotAt(trueDate, id, _callbackMaghrib,
            alarmClock: true, rescheduleOnReboot: false, wakeup: true);
        break;
      case Shalat.Isya:
        await AndroidAlarmManager.oneShotAt(trueDate, id, _callbackIsya,
            alarmClock: true, rescheduleOnReboot: false, wakeup: true);
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

  static updateJadwal() {}
}
