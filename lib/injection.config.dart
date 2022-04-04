// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i11;

import 'bloc/alarm/alarm_bloc.dart' as _i16;
import 'bloc/jadwal/jadwal_bloc.dart' as _i15;
import 'data/repository/local/jadwal_dao.dart' as _i6;
import 'data/repository/local/local_data_source.dart' as _i12;
import 'data/repository/local/location_dao.dart' as _i7;
import 'data/repository/remote/api_service.dart' as _i4;
import 'data/repository/remote/remote_data_source.dart' as _i10;
import 'data/repository/repository_dart.dart' as _i13;
import 'di/app_module.dart' as _i17;
import 'service/alarm/alarm_adzan.dart' as _i3;
import 'service/alarm/alarm_manager.dart' as _i14;
import 'service/notification/notification.service.dart' as _i9;
import 'service/notification/notification_manager.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.factory<_i3.AlarmAdzan>(() => _i3.AlarmAdzan());
  gh.factory<_i4.ApiService>(() => _i4.ApiService());
  await gh.factoryAsync<_i5.FlutterLocalNotificationsPlugin>(
      () => appModule.notification,
      preResolve: true);
  gh.factory<_i6.JadwalDao>(() => _i6.JadwalDao());
  gh.factory<_i7.LocationDao>(() => _i7.LocationDao());
  gh.factory<_i8.NotificationManager>(() => _i8.NotificationManager());
  gh.factory<_i9.NotificationService>(() => _i9.NotificationService());
  gh.factory<_i10.RemoteDataSource>(
      () => _i10.RemoteDataSource(get<_i4.ApiService>()));
  await gh.factoryAsync<_i11.SharedPreferences>(() => appModule.prefs,
      preResolve: true);
  gh.factory<_i12.LocalDataSource>(
      () => _i12.LocalDataSource(get<_i7.LocationDao>(), get<_i6.JadwalDao>()));
  gh.factory<_i13.Repository>(() => _i13.Repository(
      get<_i12.LocalDataSource>(), get<_i10.RemoteDataSource>()));
  gh.factory<_i14.AlarmManager>(() => _i14.AlarmManager(get<_i13.Repository>(),
      get<_i3.AlarmAdzan>(), get<_i8.NotificationManager>()));
  gh.factory<_i15.JadwalBloc>(() => _i15.JadwalBloc(get<_i13.Repository>()));
  gh.factory<_i16.AlarmBloc>(() => _i16.AlarmBloc(get<_i14.AlarmManager>()));
  return get;
}

class _$AppModule extends _i17.AppModule {}
