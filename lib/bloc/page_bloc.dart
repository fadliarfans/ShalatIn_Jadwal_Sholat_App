import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageInitial()) {
    on<ToHome>((event, emit) {
      emit(HomePageState());
    });
    on<ToJadwalShalat>((event, emit) {
      emit(JadwalShalatPageState());
    });
    on<ToAbout>((event, emit) {
      emit(AboutPageState());
    });
    on<ToInspiration>((event, emit) {
      emit(InspirationPageState());
    });
  }
}
