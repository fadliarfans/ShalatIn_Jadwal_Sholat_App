part of 'alarm_bloc.dart';

abstract class AlarmState extends Equatable {
  const AlarmState();

  @override
  List<Object> get props => [];
}

class AlarmInitial extends AlarmState {}

class AlarmActivatedState extends AlarmState {
  final Map<Shalat, bool> mapOfActivatedAlarm;
  const AlarmActivatedState(this.mapOfActivatedAlarm);

  @override
  List<Object> get props => [mapOfActivatedAlarm];
}
