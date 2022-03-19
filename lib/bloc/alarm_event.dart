part of 'alarm_bloc.dart';

abstract class AlarmEvent extends Equatable {
  const AlarmEvent();

  @override
  List<Object> get props => [];
}

class LaunchAlarm extends AlarmEvent {}

class LaunchAlarmOnTime extends AlarmEvent {
  final Shalat shalat;
  const LaunchAlarmOnTime(this.shalat);
}

class CancelAlaramOnTime extends AlarmEvent {
  final Shalat shalat;
  const CancelAlaramOnTime(this.shalat);
}
