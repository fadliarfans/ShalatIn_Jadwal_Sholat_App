import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jadwal_sholat_app/service/alarm/alarm_adzan.dart';
import 'package:jadwal_sholat_app/service/alarm/alarm_manager.dart';

import '../data/shalat_model.dart';

part 'alarm_event.dart';
part 'alarm_state.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  AlarmBloc() : super(AlarmInitial()) {
    final alarmManager = AlarmManager(iAlarm: AlarmAdzan());

    // int getIdSholat(Shalat shalat) {
    //   switch (shalat) {
    //     case Shalat.Subuh:
    //       return 11;
    //     case Shalat.Dzuhur:
    //       return 22;
    //     case Shalat.Ashar:
    //       return 33;
    //     case Shalat.Maghrib:
    //       return 44;
    //     case Shalat.Isya:
    //       return 55;
    //     default:
    //       return 11;
    //   }
    // }

    on<LaunchAlarm>((event, emit) {
      alarmManager.playAlarm();
    });

    on<LaunchAlarmOnTime>(((event, emit) {}));
  }
}
