import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:jadwal_sholat_app/data/jadwal_model.dart';
import 'package:jadwal_sholat_app/data/jadwal_response.dart';
import 'package:jadwal_sholat_app/data/shalat_model.dart';
import 'package:jadwal_sholat_app/extension/day_translate.dart';
import 'package:jadwal_sholat_app/extension/month_translate.dart';

part 'jadwal_event.dart';
part 'jadwal_state.dart';

class JadwalBloc extends Bloc<JadwalEvent, JadwalState> {
  JadwalBloc() : super(JadwalInitial()) {
    ShalatModel _getClosesTime(List<String> jadwalList) {
      final now = DateTime.now();
      final hour = now.hour;
      final minutes = now.minute;
      List<int> jadwalHour =
          jadwalList.map((e) => int.parse(e.substring(0, 2))).toList();
      List<int> jadwalMinutes =
          jadwalList.map((e) => int.parse(e.substring(3, 5))).toList();
      var nextJadwalHour = jadwalHour[0];
      var nextJadwalMinutes = jadwalMinutes[0];
      Shalat shalat = Shalat.Subuh;
      var counter = 0;
      for (var i = 0; i < jadwalHour.length; i++) {
        if (hour == jadwalHour[i]) {
          if (minutes < jadwalMinutes[i]) {
            nextJadwalHour = jadwalHour[i];
            nextJadwalMinutes = jadwalMinutes[i];
            counter = i;
          } else {
            nextJadwalHour = jadwalHour[i + 1];
            nextJadwalMinutes = jadwalMinutes[i + 1];
            counter = i + 1;
          }
        } else if (hour > jadwalHour[i]) {
          if (i == (jadwalHour.length - 1)) {
            nextJadwalHour = jadwalHour[0];
            nextJadwalMinutes = jadwalMinutes[0];
            counter = 0;
          } else {
            nextJadwalHour = jadwalHour[i + 1];
            nextJadwalMinutes = jadwalMinutes[i + 1];
            counter = i + 1;
          }
        }
      }
      if (counter == 0) {
        shalat = Shalat.Subuh;
      } else if (counter == 1) {
        shalat = Shalat.Dzuhur;
      } else if (counter == 2) {
        shalat = Shalat.Ashar;
      } else if (counter == 3) {
        shalat = Shalat.Maghrib;
      } else if (counter == 4) {
        shalat = Shalat.Isya;
      }
      final String nextHourString = nextJadwalHour.toString().padLeft(2, "0");
      final String nextMinuteString =
          nextJadwalMinutes.toString().padLeft(2, "0");
      final String time = "$nextHourString:$nextMinuteString";
      return ShalatModel(
          shalat: shalat,
          hour: nextJadwalHour,
          minute: nextJadwalMinutes,
          time: time);
    }

    String _getIdDate() {
      final now = DateTime.now();
      final day = DateFormat('EEEE').format(now);
      final dayId = day.translateDayToID();
      final month = DateFormat('MMMM').format(now);
      final monthId = month.translateMonthToID();
      final dayInThisMonth = DateFormat('dd').format(now);
      final year = DateFormat('yyyy').format(now);
      String formattedDate = "$dayId, $dayInThisMonth $monthId $year";
      return formattedDate;
    }

    Future<Position> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition();
    }

    Future<JadwalResponse> getJadwal(
        double latitude, double longitude, double elevation) async {
      final now = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);
      final response = await Dio().get(
          "https://api.pray.zone/v2/times/day.json?longitude=$longitude&latitude=$latitude&elevation=$elevation&date=$formattedDate");

      if (response.statusCode == 200) {
        final jadwal = JadwalResponse.fromJson(response.data);
        return jadwal;
      } else {
        return JadwalResponse(code: 0, result: null, status: "Error");
      }
    }

    on<GetJadwal>((event, emit) async {
      try {
        emit(JadwalLoading());
        final position = await _determinePosition();
        if (kDebugMode) {
          print(position.toString());
        }
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (kDebugMode) {
          print(placemarks[0]);
        }
        final jadwal = await getJadwal(
            position.latitude, position.longitude, position.altitude);
        if (jadwal.result != null) {
          final times = jadwal.result?.listDateTime?.first.times;
          ShalatModel nextJadwal = _getClosesTime([
            times?.fajr ?? "00:00",
            times?.dhuhr ?? "00:00",
            times?.asr ?? "00:00",
            times?.maghrib ?? "00:00",
            times?.isha ?? "00:00"
          ]);
          emit(JadwalSucces(jadwal.result!, _getIdDate(), nextJadwal));
        } else {
          emit(const JadwalError("Something Error Happened"));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        emit(JadwalError(e.toString()));
      }
    });
  }
}
