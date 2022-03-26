import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jadwal_sholat_app/data/my_jadwal_model.dart';
import 'package:jadwal_sholat_app/service/jadwal/jadwal_api_second.dart';
import 'package:jadwal_sholat_app/service/location/location_gps.dart';
import 'package:jadwal_sholat_app/service/location/location_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/my_location_model.dart';
import '../../data/shalat_model.dart';
import '../../extension/day_translate.dart';
import '../../extension/month_translate.dart';
import '../../service/jadwal/jadwal_api_first.dart';
import '../../service/jadwal/jadwal_local.dart';
import '../../service/jadwal/jadwal_manager.dart';
import '../../vo/status.dart';
import '../../service/location/location_manager.dart';
import '../../vo/resource.dart';

part 'jadwal_event.dart';
part 'jadwal_state.dart';

class JadwalBloc extends Bloc<JadwalEvent, JadwalState> {
  JadwalBloc() : super(JadwalInitial()) {
    Future<Resource<MyLocationModel>> getLocation() async {
      try {
        Resource<MyLocationModel> resourceLocation;
        LocationManager locationManager = LocationManager(LocationGps());
        // By GPS
        resourceLocation = await locationManager.getLocation();

        // IF Get Location from GPS Failed -> get from local
        if (resourceLocation.status == Status.ERROR ||
            resourceLocation.status == null) {
          locationManager.setILocation(LocationLocal());
          resourceLocation = await locationManager.getLocation();
        }

        if (resourceLocation.status == Status.SUCCES) {
          return resourceLocation;
        } else {
          return Resource<MyLocationModel>().error(resourceLocation.message!);
        }
      } catch (e) {
        return Resource<MyLocationModel>().error(e.toString());
      }
    }

    Future<Resource<MyJadwalModel>> getJadwal(MyLocationModel location) async {
      try {
        Resource<MyJadwalModel>? resourceJadwal;
        final prefs = await SharedPreferences.getInstance();
        final cityId = prefs.getString("cityId");
        final day = prefs.getInt("day");
        final month = prefs.getInt("month");
        final year = prefs.getInt("year");
        final now = DateTime.now();

        JadwalManager jadwalManager = JadwalManager(JadwalLocal());

        // NOTE : Jika Lokasi dan tanggal sama dengan yang disimpan, maka data diambil dari lokal.
        if (cityId == location.cityId &&
            day == now.day &&
            month == now.month &&
            year == now.year) {
          resourceJadwal = await jadwalManager.getJadwal(location);
        } else {
          // NOTE : get from first API
          jadwalManager.setIJadwal(JadwalApiFirst());
          resourceJadwal = await jadwalManager.getJadwal(location);
          if (resourceJadwal.status == Status.SUCCES) {
            final jadwal = resourceJadwal.data;
            jadwalManager.saveJadwal(jadwal!);
          } else {
            // NOTE : get from Second API
            jadwalManager.setIJadwal(JadwalApiSecond());
            resourceJadwal = await jadwalManager.getJadwal(location);
            if (resourceJadwal.status == Status.SUCCES) {
              final jadwal = resourceJadwal.data;
              jadwalManager.saveJadwal(jadwal!);
            }
          }
        }

        if (resourceJadwal.status == Status.SUCCES) {
          return resourceJadwal;
        } else {
          return Resource<MyJadwalModel>().error(resourceJadwal.message!);
        }
      } catch (e) {
        return Resource<MyJadwalModel>().error(e.toString());
      }
    }

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

      switch (counter) {
        case 0:
          shalat = Shalat.Subuh;
          break;
        case 1:
          shalat = Shalat.Dzuhur;
          break;
        case 2:
          shalat = Shalat.Ashar;
          break;
        case 3:
          shalat = Shalat.Maghrib;
          break;
        default:
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
        Resource<MyLocationModel>? resourceLocation;

        if (event is GetJadwalLocationManual) {
          // Get Location Manual
          resourceLocation = Resource<MyLocationModel>().success(
              event.myLocation,
              message: "LOCATION SUCCESS ----> Get Location Manual");
        } else {
          // Get Location Automatic
          resourceLocation = await getLocation();
        }

        debugPrint(resourceLocation.message);

        if (resourceLocation.status == Status.SUCCES) {
          final resourceJadwal = await getJadwal(resourceLocation.data!);

          debugPrint(resourceJadwal.message);

          if (resourceJadwal.status == Status.SUCCES) {
            await LocationManager(LocationLocal()).saveLocation(
                resourceLocation.data!.city!,
                resourceLocation.data!.country!,
                resourceLocation.data!.cityId!);
            final jadwal = resourceJadwal.data;
            ShalatModel nextJadwal = _getClosesTime([
              jadwal?.fajr ?? "00:00",
              jadwal?.dhuhr ?? "00:00",
              jadwal?.asr ?? "00:00",
              jadwal?.maghrib ?? "00:00",
              jadwal?.isha ?? "00:00"
            ]);
            final mapOfJadwalSholat = {
              Shalat.Subuh: jadwal?.fajr ?? "",
              Shalat.Dzuhur: jadwal?.dhuhr ?? "",
              Shalat.Ashar: jadwal?.asr ?? "",
              Shalat.Maghrib: jadwal?.maghrib ?? "",
              Shalat.Isya: jadwal?.isha ?? ""
            };
            final myLocation = resourceLocation.data!;
            emit(JadwalSucces(
                mapOfJadwalSholat, _getIdDate(), nextJadwal, myLocation));
          } else {
            emit(const JadwalError("Something Error Happened"));
          }
        } else {
          emit(JadwalChooseCity());
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(const JadwalError("Something Error Happened"));
      }
    });
  }
}
