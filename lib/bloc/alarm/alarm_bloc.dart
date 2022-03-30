import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/alarm/alarm_manager.dart';
import '../../data/shalat_model.dart';

part 'alarm_event.dart';
part 'alarm_state.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  AlarmBloc() : super(AlarmInitial()) {
    final alarmManager = AlarmManager();

    Future<Map<Shalat, bool>> _getActivedJadwal() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final ashar = sharedPreferences.getBool(Shalat.Ashar.name);
      final subuh = sharedPreferences.getBool(Shalat.Subuh.name);
      final dzuhur = sharedPreferences.getBool(Shalat.Dzuhur.name);
      final isya = sharedPreferences.getBool(Shalat.Isya.name);
      final maghrib = sharedPreferences.getBool(Shalat.Maghrib.name);
      final map = {
        Shalat.Ashar: ashar ?? false,
        Shalat.Dzuhur: dzuhur ?? false,
        Shalat.Isya: isya ?? false,
        Shalat.Subuh: subuh ?? false,
        Shalat.Maghrib: maghrib ?? false
      };
      return map;
    }

    on<GetAlarm>(((event, emit) async {
      emit(AlarmActivatedState(await _getActivedJadwal()));
    }));

    on<ActivateAlarm>(((event, emit) async {
      await alarmManager.activateAlarm(event.shalat);
      emit(AlarmActivatedState(await _getActivedJadwal()));
    }));

    on<CancelAlarm>(((event, emit) async {
      await alarmManager.cancelAlarm(event.shalat);
      emit(AlarmActivatedState(await _getActivedJadwal()));
    }));
  }
}
