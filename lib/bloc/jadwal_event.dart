part of 'jadwal_bloc.dart';

abstract class JadwalEvent extends Equatable {
  const JadwalEvent();

  @override
  List<Object> get props => [];
}

class GetJadwal extends JadwalEvent {}