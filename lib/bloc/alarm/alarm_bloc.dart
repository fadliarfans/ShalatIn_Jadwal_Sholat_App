import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../service/alarm/alarm_manager.dart';
import '../../data/models/shalat_model.dart';

part 'alarm_event.dart';

part 'alarm_state.dart';

@Injectable()
class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  final AlarmManager _alarmManager;

  int counter = 0;

  AlarmBloc(this._alarmManager) : super(AlarmInitial()) {
    try {
      if (counter < 1) {
        _alarmManager.monthlyAlarm();
        counter++;
      }

      on<GetAlarm>(((event, emit) async {
        emit(AlarmActivatedState(_alarmManager.myActivatedJadwal));
      }));

      on<ActivateAlarm>(((event, emit) async {
        try {
          await _alarmManager.activateAlarm(event.shalat);
          emit(
              AlarmActivatedState(await _alarmManager.getAllActivatedJadwal()));
        } catch (e) {
          debugPrint("ACTIVATE ALARM BLOC ERROR -----> $e");
          await _alarmManager.cancelAlarm(event.shalat);
          emit(
              AlarmActivatedState(await _alarmManager.getAllActivatedJadwal()));
        }
      }));

      on<CancelAlarm>(((event, emit) async {
        await _alarmManager.cancelAlarm(event.shalat);
        emit(AlarmActivatedState(await _alarmManager.getAllActivatedJadwal()));
      }));
    } catch (e) {
      debugPrint("ALARM BLOC ERROR ----> $e");
    }
  }
}
