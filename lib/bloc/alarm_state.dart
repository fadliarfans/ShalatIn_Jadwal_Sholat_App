part of 'alarm_bloc.dart';

abstract class AlarmState extends Equatable {
  const AlarmState();

  @override
  List<Object> get props => [];
}

class AlarmInitial extends AlarmState {}

class AlarmSuccesLaunch extends AlarmState {}

class AlarmFailedLaunch extends AlarmState {}
