import 'dart:math';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:jadwal_sholat_app/service/alarm/alarm_adzan.dart';
import 'package:jadwal_sholat_app/vo/resource.dart';
import 'package:jadwal_sholat_app/vo/status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/my_jadwal_model.dart';
import '../../data/models/my_location_model.dart';
import '../../data/models/shalat_model.dart';
import 'i_alarm.dart';

class AlarmManager {
  // static final IAlarm iAlarm = AlarmAdzan();
  // static Shalat shalatStatic = Shalat.Subuh;
  //
  // activateAlarm(Shalat shalat) async {
  //   shalatStatic = shalat;
  //
  //   await activateTodayAlarm(shalat);
  //   await activateTommorowAlarm(shalat);
  // }
  //
  // static periodicTomorrowCallback() async {
  //   iAlarm.playAdzan(await _getTime(shalatStatic), shalatStatic.index + 300);
  // }
  //
  // static tomorrowOneShotAtCallback() {
  //   AndroidAlarmManager.periodic(const Duration(hours: 24),
  //       shalatStatic.index + 200, periodicTomorrowCallback);
  // }
  //
  // activateTommorowAlarm(Shalat shalat) async {
  //   try {
  //     final pref = await SharedPreferences.getInstance();
  //     pref.setBool(shalat.name, true);
  //     DateTime now = DateTime.now();
  //     await AndroidAlarmManager.oneShotAt(
  //         DateTime(now.year, now.month, now.day, 1, Random().nextInt(60),
  //                 Random().nextInt(60))
  //             .add(const Duration(days: 1)),
  //         shalat.index + 100,
  //         tomorrowOneShotAtCallback);
  //   } catch (e) {
  //     debugPrint("ERROR ----> $e");
  //   }
  // }
  //
  // activateTodayAlarm(Shalat shalat) async {
  //   try {
  //     final times = await _getTimeLocal(shalat);
  //     DateTime now = DateTime.now();
  //
  //     if (now.hour > times.hour) {
  //       return;
  //     }
  //
  //     if (now.hour == times.hour) {
  //       if (now.minute > times.minute) {
  //         return;
  //       }
  //     }
  //
  //     print("Activate alarm today");
  //     iAlarm.playAdzan(times, shalat.index + 300);
  //   } catch (e) {
  //     print(e.toString());
  //     rethrow;
  //   }
  // }
  //
  // cancelAlarm(Shalat shalat) async {
  //   final pref = await SharedPreferences.getInstance();
  //   pref.setBool(shalat.name, false);
  //   await AndroidAlarmManager.cancel(shalat.index + 100);
  //   await AndroidAlarmManager.cancel(shalat.index + 200);
  //   await AndroidAlarmManager.cancel(shalat.index + 300);
  // }
  //
  // static Future<DateTime> _getTimeLocal(Shalat shalat) async {
  //   try {
  //     final locationManager = LocationManager(LocationLocal());
  //     Resource<MyLocationModel> resourceLocation =
  //         await locationManager.getLocation();
  //
  //     final jadwalManager = JadwalManager(JadwalLocal());
  //     Resource<MyJadwalModel> resourceJadwal =
  //         await jadwalManager.getJadwal(resourceLocation.data!);
  //
  //     if (resourceJadwal.status == Status.SUCCES) {
  //       final times = resourceJadwal.data!;
  //       jadwalManager.saveJadwal(times);
  //       DateTime now = DateTime.now();
  //       final hour = times.getTime(shalat).hour;
  //       final minute = times.getTime(shalat).minute;
  //       print("${times.getTime(shalat).hour}:${times.getTime(shalat).minute}");
  //       return DateTime(now.year, now.month, now.day, hour, minute);
  //     } else {
  //       throw Exception("Failed Get Jadwal");
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     rethrow;
  //   }
  // }
  //
  // static Future<DateTime> _getTime(Shalat shalat) async {
  //   try {
  //     final locationManager = LocationManager(LocationGps());
  //     Resource<MyLocationModel> resourceLocation =
  //         await locationManager.getLocation();
  //
  //     if (resourceLocation.status == Status.ERROR) {
  //       locationManager.setILocation(LocationLocal());
  //       resourceLocation = await locationManager.getLocation();
  //     } else {
  //       locationManager.saveLocation(resourceLocation.data!);
  //     }
  //
  //     final jadwalManager = JadwalManager(JadwalApiFirst());
  //     Resource<MyJadwalModel> resourceJadwal =
  //         await jadwalManager.getJadwal(resourceLocation.data!);
  //
  //     if (resourceJadwal.status == Status.ERROR) {
  //       jadwalManager.setIJadwal(JadwalApiSecond());
  //       resourceJadwal = await jadwalManager.getJadwal(resourceLocation.data!);
  //     }
  //
  //     if (resourceJadwal.status == Status.SUCCES) {
  //       final times = resourceJadwal.data!;
  //       jadwalManager.saveJadwal(times);
  //       DateTime now = DateTime.now();
  //       final hour = times.getTime(shalat).hour;
  //       final minute = times.getTime(shalat).minute;
  //       print("${times.getTime(shalat).hour}:${times.getTime(shalat).minute}");
  //       return DateTime(now.year, now.month, now.day, hour, minute);
  //     } else {
  //       throw Exception("Failed Get Jadwal");
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
