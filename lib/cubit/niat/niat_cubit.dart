import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jadwal_sholat_app/data/models/shalat_model.dart';

part 'niat_state.dart';

class NiatCubit extends Cubit<NiatState> {
  NiatCubit() : super(NiatInitial());

  chooseNiat(Shalat shalat) {
    emit(NiatChoosed(shalat));
  }
}
