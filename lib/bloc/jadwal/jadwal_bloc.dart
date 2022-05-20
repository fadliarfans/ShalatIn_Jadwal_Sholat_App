import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:jadwal_sholat_app/data/models/my_jadwal_model.dart';
import 'package:jadwal_sholat_app/data/repository/repository_dart.dart';
import 'package:jadwal_sholat_app/service/alarm/alarm_manager.dart';
import '../../data/models/my_location_model.dart';
import '../../data/models/shalat_model.dart';
import '../../extension/day_translate.dart';
import '../../extension/month_translate.dart';
import '../../vo/status.dart';
import '../../vo/resource.dart';

part 'jadwal_event.dart';

part 'jadwal_state.dart';

@Injectable()
class JadwalBloc extends Bloc<JadwalEvent, JadwalState> {
  final Repository _repository;
  final AlarmManager _alarmManager;

  Map<Shalat, String>? mapOfJadwalSholat;
  MyLocationModel? myLocation;
  ShalatModel? nextJadwal;
  List<MyJadwalModel>? jadwalList;
  MyJadwalModel? jadwalToday;
  int nowDay = 1;

  JadwalBloc(this._repository, this._alarmManager) : super(JadwalInitial()) {
    Future<Resource<MyLocationModel>> getLocation() async {
      try {
        Resource<MyLocationModel> resourceLocation;

        // By GPS
        resourceLocation = await _repository.getLocation();

        if (resourceLocation.status == Status.SUCCES) {
          return resourceLocation;
        } else {
          return Resource<MyLocationModel>().error(resourceLocation.message!);
        }
      } catch (e) {
        return Resource<MyLocationModel>().error(e.toString());
      }
    }

    Future<Resource<List<MyJadwalModel>>> getJadwal(
        MyLocationModel location) async {
      try {
        Resource<List<MyJadwalModel>>? resourceJadwal;

        resourceJadwal = await _repository.getJadwal(location);

        if (resourceJadwal.status == Status.SUCCES) {
          //_repository.saveJadwal(resourceJadwal.data!);
        }
        return resourceJadwal;
      } catch (e) {
        return Resource<List<MyJadwalModel>>().error(e.toString());
      }
    }

    ShalatModel _getClosesTime(MyJadwalModel myJadwalModel) {
      final now = DateTime.now();
      final hour = now.hour;
      final minutes = now.minute;

      List<int> jadwalHour = [
        myJadwalModel.fajr.hour,
        myJadwalModel.dhuhr.hour,
        myJadwalModel.asr.hour,
        myJadwalModel.maghrib.hour,
        myJadwalModel.isha.hour,
      ];

      List<int> jadwalMinutes = [
        myJadwalModel.fajr.minute,
        myJadwalModel.dhuhr.minute,
        myJadwalModel.asr.minute,
        myJadwalModel.maghrib.minute,
        myJadwalModel.isha.minute,
      ];

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
      final year = DateFormat('yyyy').format(now);
      String formattedDate = "$dayId, $nowDay $monthId $year";
      return formattedDate;
    }

    on<RefreshJadwal>((event, emit) {
      if (mapOfJadwalSholat != null &&
          myLocation != null &&
          jadwalList != null) {
        nextJadwal = _getClosesTime(jadwalToday!);
        emit(JadwalSucces(
            mapOfJadwalSholat!, _getIdDate(), nextJadwal!, myLocation!));
      }
    });

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
            await _repository.saveLocation(resourceLocation.data!);
            nowDay = DateTime.now().day;

            jadwalList = resourceJadwal.data!;
            jadwalToday = jadwalList![nowDay - 1];

            nextJadwal = _getClosesTime(jadwalToday!);

            mapOfJadwalSholat = {
              Shalat.Subuh: jadwalToday!.fajr.timeS,
              Shalat.Dzuhur: jadwalToday!.dhuhr.timeS,
              Shalat.Ashar: jadwalToday!.asr.timeS,
              Shalat.Maghrib: jadwalToday!.maghrib.timeS,
              Shalat.Isya: jadwalToday!.isha.timeS
            };

            // initiate location
            myLocation = resourceLocation.data!;

            // Activated Alarm
            if (event is GetJadwalLocationManual) {
              final activatedJadwal =
                  await _alarmManager.getAllActivatedJadwal();
              activatedJadwal.forEach((key, value) async {
                if (value) {
                  await _alarmManager.cancelAlarm(key);
                  await _alarmManager.activateAlarm(key);
                }
              });
            }

            emit(JadwalSucces(
                mapOfJadwalSholat!, _getIdDate(), nextJadwal!, myLocation!));
          } else {
            emit(const JadwalError("Something Error Happened"));
          }
        } else {
          debugPrint("JADWAL ERROR : Choose Manual");
          emit(JadwalChooseCity());
        }
      } catch (e) {
        debugPrint("JADWAL ERROR : $e");
        emit(const JadwalError("Something Error Happened"));
      }
    });
  }
}
