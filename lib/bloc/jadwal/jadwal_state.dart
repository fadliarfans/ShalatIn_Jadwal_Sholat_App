part of 'jadwal_bloc.dart';

abstract class JadwalState extends Equatable {
  const JadwalState();

  @override
  List<Object> get props => [];
}

class JadwalInitial extends JadwalState {}

class JadwalSucces extends JadwalState {
  final Map<Shalat, String> jadwalFiveTimePrayer;
  final String dateId;
  final ShalatModel nextJadwal;
  final MyLocationModel location;
  const JadwalSucces(
      this.jadwalFiveTimePrayer, this.dateId, this.nextJadwal, this.location);
}

class JadwalError extends JadwalState {
  final String error;
  const JadwalError(this.error);
}

class JadwalLoading extends JadwalState {}

class JadwalChooseCity extends JadwalLoading {}
