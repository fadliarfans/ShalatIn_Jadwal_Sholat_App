import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:jadwal_sholat_app/data/my_location_model.dart';
import 'package:jadwal_sholat_app/data/shalat_model.dart';
import 'package:jadwal_sholat_app/extension/day_translate.dart';
import 'package:jadwal_sholat_app/extension/month_translate.dart';
import 'package:jadwal_sholat_app/service/jadwal/jadwal_coordinate.dart';
import 'package:jadwal_sholat_app/service/jadwal/jadwal_manager.dart';
import 'package:jadwal_sholat_app/vo/status.dart';

import '../service/location/location_gps.dart';
import '../service/location/location_ip.dart';
import '../service/location/location_manager.dart';
import '../vo/resource.dart';

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

    on<GetJadwal>((event, emit) async {
      try {
        emit(JadwalLoading());
        Resource<MyLocation> resourceLocation;

        // By GPS
        LocationManager locationManager = LocationManager(LocationGps());
        resourceLocation = await locationManager.getPostition();

        if (kDebugMode) {
          print("GPS Status : ${resourceLocation.status}");
        }

        // By IP if GPS failed
        if (resourceLocation.status == Status.ERROR ||
            resourceLocation.status == null) {
          locationManager = LocationManager(LocationIp());
          resourceLocation = await locationManager.getPostition();
          if (kDebugMode) {
            print("IP Status : ${resourceLocation.status}");
          }
        }

        if (resourceLocation.status == Status.SUCCES) {
          final JadwalManager jadwalManager = JadwalManager(JadwalCoordinate());
          final resourceJadwal =
              await jadwalManager.getJadwal(resourceLocation.data!);
          if (kDebugMode) {
            print("Jadwal Status : ${resourceJadwal.status}");
          }
          if (resourceJadwal.status == Status.SUCCES) {
            final jadwal = resourceJadwal.data;
            final times = jadwal?.result?.listDateTime?.first.times;
            ShalatModel nextJadwal = _getClosesTime([
              times?.fajr ?? "00:00",
              times?.dhuhr ?? "00:00",
              times?.asr ?? "00:00",
              times?.maghrib ?? "00:00",
              times?.isha ?? "00:00"
            ]);
            final listFiveTimes = jadwal?.result?.listDateTime?.first.times;
            final mapOfJadwalSholat = {
              Shalat.Subuh: listFiveTimes?.fajr ?? "",
              Shalat.Dzuhur: listFiveTimes?.dhuhr ?? "",
              Shalat.Ashar: listFiveTimes?.asr ?? "",
              Shalat.Maghrib: listFiveTimes?.maghrib ?? "",
              Shalat.Isya: listFiveTimes?.isha ?? ""
            };
            final myLocation = resourceLocation.data!;
            emit(JadwalSucces(
                mapOfJadwalSholat, _getIdDate(), nextJadwal, myLocation));
          } else {
            emit(const JadwalError("Something Error Happened"));
          }
        } else {
          emit(const JadwalError("Something Error Happened"));
        }
      } catch (e) {
        emit(JadwalError(e.toString()));
      }
    });
  }
}
