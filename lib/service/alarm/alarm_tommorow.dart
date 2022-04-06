import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jadwal_sholat_app/data/models/my_jadwal_model.dart';
import 'package:jadwal_sholat_app/data/repository/remote/api_service.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_ios/path_provider_ios.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/my_location_model.dart';
import '../../data/models/shalat_model.dart';
import '../../data/repository/remote/remote_data_source.dart';
import '../../vo/status.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmTommorow {
  activateTommorowAlarm(Shalat shalat) async {
    try {
      DateTime now = DateTime.now();
      var tommorow = DateTime(
        now.year, now.month, now.day, 1,
        //  Random().nextInt(60),
        //         Random().nextInt(60)
      ).add(const Duration(days: 1));
      await AndroidAlarmManager.oneShotAt(
          tommorow, shalat.index + 100, tommorowShot);
      debugPrint("SUCCESS -----> activateTommorowAlarm");
    } catch (e) {
      debugPrint("ERROR ----> $e");
    }
  }

  static tommorowShot() {
    debugPrint("Tommorow shot");
    getJadwalAgain();
    AndroidAlarmManager.periodic(
        const Duration(hours: 24), 999 + 200, getJadwalAgain);
  }

  static getJadwalAgain() async {
    debugPrint("getJadwalAgain");
    Shalat shalat = Shalat.Ashar;
    final times = await _getTimeLocalStatic(shalat);
    debugPrint("Tommorow Next shot");

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {});

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
    });

    _time(hour, minute) {
      final time = tz.TZDateTime.now(tz.local);
      final nextTime = tz.TZDateTime(
          tz.local, time.year, time.month, time.day, hour, minute);
      return nextTime;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
        999 + 400,
        "${times.hour.toString().padLeft(2, "0")}:${times.minute.toString().padLeft(2, "0")}",
        "Ayo Shalat ${shalat.name}, udah masuk waktunya nih !",
        _time(times.hour, times.minute),
        NotificationDetails(
            android: AndroidNotificationDetails(
                '${shalat.name} ${400}', shalat.name,
                channelDescription: 'Shalat ${shalat.name} Notification')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    debugPrint("SUCCESS -----> tommorowShot");
  }

  static _getLocation() async {
    if (Platform.isAndroid) PathProviderAndroid.registerWith();
    if (Platform.isIOS) PathProviderIOS.registerWith();
    final prefs = await SharedPreferences.getInstance();
    final city = prefs.getString("city");
    final country = prefs.getString("country");
    final cityId = prefs.getString("cityId");
    if (city == null || country == null || cityId == null) {
      throw Exception("Location local not found");
    } else {
      return MyLocationModel(city: city, country: country, cityId: cityId);
    }
  }

  static _saveJadwal(MyJadwalModel jadwal) async {
    if (Platform.isAndroid) PathProviderAndroid.registerWith();
    if (Platform.isIOS) PathProviderIOS.registerWith();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Shalat.Subuh.name, jadwal.fajr.timeS);
    prefs.setString(Shalat.Dzuhur.name, jadwal.dhuhr.timeS);
    prefs.setString(Shalat.Ashar.name, jadwal.asr.timeS);
    prefs.setString(Shalat.Maghrib.name, jadwal.maghrib.timeS);
    prefs.setString(Shalat.Isya.name, jadwal.isha.timeS);
    prefs.setInt("day", jadwal.day);
    prefs.setInt("month", jadwal.month);
    prefs.setInt("year", jadwal.year);
  }

  static Future<DateTime> _getTimeLocalStatic(Shalat shalat) async {
    try {
      RemoteDataSource remoteDataSource = RemoteDataSource(ApiService());
      final resourceLocation = await _getLocation();

      final resourceJadwal =
          await remoteDataSource.getJadwal(resourceLocation.data!);

      if (resourceJadwal.status == Status.SUCCES) {
        final times = resourceJadwal.data!;
        -_saveJadwal(times);
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
