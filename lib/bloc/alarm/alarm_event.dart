part of 'alarm_bloc.dart';

abstract class AlarmEvent extends Equatable {
  const AlarmEvent();

  @override
  List<Object> get props => [];
}

class ActivateAlarm extends AlarmEvent {
  final Shalat shalat;
  const ActivateAlarm(this.shalat);
}

class CancelAlarm extends AlarmEvent {
  final Shalat shalat;
  const CancelAlarm(this.shalat);
}
