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
    on<ToRight>(((event, emit) {
      if (state is HomePageState) {
        emit(JadwalShalatPageState());
      } else if (state is JadwalShalatPageState) {
        emit(InspirationPageState());
      } else if (state is InspirationPageState) {
        emit(AboutPageState());
      }
    }));

    on<ToLeft>((event, emit) {
      if (state is JadwalShalatPageState) {
        emit(HomePageState());
      } else if (state is InspirationPageState) {
        emit(JadwalShalatPageState());
      } else if (state is AboutPageState) {
        emit(InspirationPageState());
      }
    });
  }
}
