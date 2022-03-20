part of 'alarm_bloc.dart';

abstract class AlarmEvent extends Equatable {
  const AlarmEvent();

  @override
  List<Object> get props => [];
}

class LaunchAlarmOnTime extends AlarmEvent {
  final Shalat shalat;
  const LaunchAlarmOnTime(this.shalat);
}

class CancelAlarmOnTime extends AlarmEvent {
  final Shalat shalat;
  const CancelAlarmOnTime(this.shalat);
}
