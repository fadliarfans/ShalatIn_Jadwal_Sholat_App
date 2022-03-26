import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../service/alarm/alarm_adzan.dart';
import '../../service/alarm/alarm_manager.dart';
import '../../data/shalat_model.dart';

part 'alarm_event.dart';
part 'alarm_state.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  AlarmBloc() : super(AlarmInitial()) {
    final alarmManager = AlarmManager(iAlarm: AlarmAdzan());

    int getIdSholat(Shalat shalat) {
      switch (shalat) {
        case Shalat.Subuh:
          return 1;
        case Shalat.Dzuhur:
          return 2;
        case Shalat.Ashar:
          return 3;
        case Shalat.Maghrib:
          return 4;
        case Shalat.Isya:
          return 5;
        default:
          return 1;
      }
    }

    // String getTimesSholat(Shalat shalat, List<String> times) {
    //   switch (shalat) {
    //     case Shalat.Subuh:
    //       return times[0];
    //     case Shalat.Dzuhur:
    //       return times[1];
    //     case Shalat.Ashar:
    //       return times[2];
    //     case Shalat.Maghrib:
    //       return times[3];
    //     case Shalat.Isya:
    //       return times[4];
    //     default:
    //       return times[0];
    //   }
    // }

    on<LaunchAlarmOnTime>(((event, emit) async {
      try {
        // Resource<MyLocation> resourceLocation =
        //     await LocationManager().getPostition();

        // if (resourceLocation.status == Status.SUCCES) {
        //   final resourceJadwal = getJadwal(resourceLocation.data!);

        //   if (resourceJadwal.status == Status.SUCCES) {
        //     final jadwal = resourceJadwal.data;
        //     final times = jadwal;
        //     final now = DateTime.now();
        //     final time = getTimesSholat(event.shalat, [
        //       times?.fajr ?? "",
        //       times?.dhuhr ?? "",
        //       times?.asr ?? "",
        //       times?.maghrib ?? "",
        //       times?.isha ?? ""
        //     ]);
        //     final int? hour = int.tryParse(time.substring(0, 2));
        //     final int? minute = int.tryParse(time.substring(3, 5));
        //     if (hour != null && minute != null) {
        //       alarmManager.playAlarmOnTime(
        //           DateTime(now.year, now.month, 20, hour, minute),
        //           getIdSholat(event.shalat));
        //     }
        //   }
        //}
      } catch (e) {
        //print(e.toString());
      }
    }));

    on<CancelAlarmOnTime>(((event, emit) {
      alarmManager.cancelAdzan(getIdSholat(event.shalat));
    }));
  }
}
