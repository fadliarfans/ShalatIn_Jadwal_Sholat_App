part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();

  @override
  List<Object> get props => [];
}

class ToHome extends PageEvent {}

class ToJadwalShalat extends PageEvent {}

class ToInspiration extends PageEvent {}

class ToAbout extends PageEvent {}

class ToRight extends PageEvent {}

class ToLeft extends PageEvent {}
