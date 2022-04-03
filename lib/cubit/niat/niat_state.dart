part of 'niat_cubit.dart';

abstract class NiatState extends Equatable {
  const NiatState();

  @override
  List<Object> get props => [];
}

class NiatInitial extends NiatState {}

class NiatChoosed extends NiatState {
  final Shalat shalat;
  const NiatChoosed(this.shalat);

  @override
  List<Object> get props => [shalat];
}
