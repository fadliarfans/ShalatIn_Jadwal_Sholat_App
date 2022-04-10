import 'dart:developer' as developer;
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:jadwal_sholat_app/data/repository/local/database/object_box.dart';
import 'package:jadwal_sholat_app/service/notification/notification_manager.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_ios/path_provider_ios.dart';

import '../../data/models/my_jadwal_entity.dart';
import '../../data/models/my_jadwal_model.dart';
import '../../data/models/shalat_model.dart';

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

      await AndroidAlarmManager.initialize();
      await AndroidAlarmManager.oneShotAt(await getJadwalSubuhDateTime(),
          Shalat.Subuh.index + 400, _callbackSubuh);
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

      await AndroidAlarmManager.initialize();
      await AndroidAlarmManager.oneShotAt(await getJadwalDzuhurDateTime(),
          Shalat.Dzuhur.index + 400, _callbackDzuhur);
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

      await AndroidAlarmManager.initialize();
      await AndroidAlarmManager.oneShotAt(await getJadwalAsharDateTime(),
          Shalat.Ashar.index + 400, _callbackAshar);
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

      await AndroidAlarmManager.initialize();
      await AndroidAlarmManager.oneShotAt(await getJadwalMaghribDateTime(),
          Shalat.Maghrib.index + 400, _callbackMaghrib);
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

      await AndroidAlarmManager.initialize();
      await AndroidAlarmManager.oneShotAt(await getJadwalIsyaDateTime(),
          Shalat.Isya.index + 400, _callbackIsya);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> setAlarm(DateTime date, Shalat shalat) async {
    final trueDate = date;
    if (date.isAfter(DateTime.now())) {
      trueDate.add(const Duration(days: 1));
    }
    switch (shalat) {
      case Shalat.Subuh:
        await AndroidAlarmManager.oneShotAt(
            trueDate, shalat.index + 400, _callbackSubuh);
        break;
      case Shalat.Dzuhur:
        await AndroidAlarmManager.oneShotAt(
            trueDate, shalat.index + 400, _callbackDzuhur);
        break;
      case Shalat.Ashar:
        await AndroidAlarmManager.oneShotAt(
            trueDate, shalat.index + 400, _callbackAshar);
        break;
      case Shalat.Maghrib:
        await AndroidAlarmManager.oneShotAt(
            trueDate, shalat.index + 400, _callbackMaghrib);
        break;
      case Shalat.Isya:
        await AndroidAlarmManager.oneShotAt(
            trueDate, shalat.index + 400, _callbackIsya);
        break;
    }
  }

  static Future<void> cancelAlarm(Shalat shalat) async {
    await AndroidAlarmManager.cancel(shalat.index + 400);
    NotificationManager _notificationManager = NotificationManager();
    await _notificationManager.init();
    await _notificationManager.cancelNotification(shalat);
  }

  static Future<DateTime> getJadwalSubuhDateTime() async {
    ObjectBox objectbox = await ObjectBox.create();
    final jadwalBox = objectbox.store.box<MyJadwalEntity>();
    final tommorow = DateTime.now().add(const Duration(days: 1)).day;
    MyJadwalModel myJadwalModel = jadwalBox.get(tommorow)!.toMyJadwalModel();
    DateTime datetime = DateTime(
        myJadwalModel.year,
        myJadwalModel.month,
        myJadwalModel.day,
        myJadwalModel.getTime(Shalat.Subuh).hour,
        myJadwalModel.getTime(Shalat.Subuh).minute);
    return datetime;
  }

  static Future<DateTime> getJadwalDzuhurDateTime() async {
    ObjectBox objectbox = await ObjectBox.create();
    final jadwalBox = objectbox.store.box<MyJadwalEntity>();
    final tommorow = DateTime.now().add(const Duration(days: 1)).day;
    MyJadwalModel myJadwalModel = jadwalBox.get(tommorow)!.toMyJadwalModel();
    DateTime datetime = DateTime(
        myJadwalModel.year,
        myJadwalModel.month,
        myJadwalModel.day,
        myJadwalModel.getTime(Shalat.Dzuhur).hour,
        myJadwalModel.getTime(Shalat.Dzuhur).minute);
    return datetime;
  }

  static Future<DateTime> getJadwalAsharDateTime() async {
    ObjectBox objectbox = await ObjectBox.create();
    final jadwalBox = objectbox.store.box<MyJadwalEntity>();
    final tommorow = DateTime.now().add(const Duration(days: 1)).day;
    MyJadwalModel myJadwalModel = jadwalBox.get(tommorow)!.toMyJadwalModel();
    DateTime datetime = DateTime(
        myJadwalModel.year,
        myJadwalModel.month,
        myJadwalModel.day,
        myJadwalModel.getTime(Shalat.Ashar).hour,
        myJadwalModel.getTime(Shalat.Ashar).minute);
    return datetime;
  }

  static Future<DateTime> getJadwalMaghribDateTime() async {
    ObjectBox objectbox = await ObjectBox.create();
    final jadwalBox = objectbox.store.box<MyJadwalEntity>();
    final tommorow = DateTime.now().add(const Duration(days: 1)).day;
    MyJadwalModel myJadwalModel = jadwalBox.get(tommorow)!.toMyJadwalModel();
    DateTime datetime = DateTime(
        myJadwalModel.year,
        myJadwalModel.month,
        myJadwalModel.day,
        myJadwalModel.getTime(Shalat.Maghrib).hour,
        myJadwalModel.getTime(Shalat.Maghrib).minute);
    return datetime;
  }

  static Future<DateTime> getJadwalIsyaDateTime() async {
    ObjectBox objectbox = await ObjectBox.create();
    final jadwalBox = objectbox.store.box<MyJadwalEntity>();
    final tommorow = DateTime.now().add(const Duration(days: 1)).day;
    MyJadwalModel myJadwalModel = jadwalBox.get(tommorow)!.toMyJadwalModel();
    DateTime datetime = DateTime(
        myJadwalModel.year,
        myJadwalModel.month,
        myJadwalModel.day,
        myJadwalModel.getTime(Shalat.Isya).hour,
        myJadwalModel.getTime(Shalat.Isya).minute);
    return datetime;
  }

  static updateJadwal() {}
}
