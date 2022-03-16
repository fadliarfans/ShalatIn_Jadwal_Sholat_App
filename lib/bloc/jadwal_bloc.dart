import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:jadwal_sholat_app/data/jadwal_model.dart';
import 'package:jadwal_sholat_app/data/jadwal_response.dart';

part 'jadwal_event.dart';
part 'jadwal_state.dart';

class JadwalBloc extends Bloc<JadwalEvent, JadwalState> {
  JadwalBloc() : super(JadwalInitial()) {
    Future<Position> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition();
    }

    Future<JadwalResponse> getJadwal(
        double latitude, double longitude, double elevation) async {
      final now = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);
      final response = await Dio().get(
          "https://api.pray.zone/v2/times/day.json?longitude=$longitude&latitude=$latitude&elevation=$elevation&date=$formattedDate");

      if (response.statusCode == 200) {
        final jadwal = JadwalResponse.fromJson(response.data);
        return jadwal;
      } else {
        return JadwalResponse(code: 0, result: null, status: "Error");
      }
    }

    on<GetJadwal>((event, emit) async {
      try {
        emit(JadwalLoading());
        final position = await _determinePosition();
        if (kDebugMode) {
          print(position.toString());
        }
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (kDebugMode) {
          print(placemarks[0]);
        }
        final jadwal = await getJadwal(
            position.latitude, position.longitude, position.altitude);
        if (jadwal.result != null) {
          emit(JadwalSucces(jadwal.result!));
        } else {
          emit(const JadwalError("Something Error Happened"));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        emit(JadwalError(e.toString()));
      }
    });
  }
}
