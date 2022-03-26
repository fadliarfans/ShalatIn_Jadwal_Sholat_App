import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../service/alarm/alarm_adzan.dart';
import '../../service/alarm/alarm_manager.dart';
import '../../data/shalat_model.dart';

part 'alarm_event.dart';
part 'alarm_state.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  AlarmBloc() : super(AlarmInitial()) {
    final alarmManager = AlarmManager();

    on<ActivateAlarm>(((event, emit) {
      alarmManager.activateTommorowAlarm(event.shalat);
    }));

    on<CancelAlarm>(((event, emit) {
      alarmManager.cancelAlarm(event.shalat);
    }));
  }
}
