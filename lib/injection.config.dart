// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import 'bloc/alarm/alarm_bloc.dart' as _i13;
import 'bloc/jadwal/jadwal_bloc.dart' as _i12;
import 'data/repository/local/jadwal_dao.dart' as _i5;
import 'data/repository/local/local_data_source.dart' as _i9;
import 'data/repository/local/location_dao.dart' as _i6;
import 'data/repository/remote/api_service.dart' as _i4;
import 'data/repository/remote/remote_data_source.dart' as _i7;
import 'data/repository/repository_dart.dart' as _i10;
import 'di/app_module.dart' as _i14;
import 'service/alarm/alarm_manager.dart' as _i11;
import 'service/alarm/alarm_service.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.factory<_i3.AlarmService>(() => _i3.AlarmService());
  gh.factory<_i4.ApiService>(() => _i4.ApiService());
  gh.factory<_i5.JadwalDao>(() => _i5.JadwalDao());
  gh.factory<_i6.LocationDao>(() => _i6.LocationDao());
  gh.factory<_i7.RemoteDataSource>(
      () => _i7.RemoteDataSource(get<_i4.ApiService>()));
  await gh.factoryAsync<_i8.SharedPreferences>(() => appModule.prefs,
      preResolve: true);
  gh.factory<_i9.LocalDataSource>(
      () => _i9.LocalDataSource(get<_i6.LocationDao>(), get<_i5.JadwalDao>()));
  gh.factory<_i10.Repository>(() =>
      _i10.Repository(get<_i9.LocalDataSource>(), get<_i7.RemoteDataSource>()));
  gh.factory<_i11.AlarmManager>(
      () => _i11.AlarmManager(get<_i10.Repository>(), get<_i3.AlarmService>()));
  gh.factory<_i12.JadwalBloc>(() => _i12.JadwalBloc(get<_i10.Repository>()));
  gh.factory<_i13.AlarmBloc>(() => _i13.AlarmBloc(get<_i11.AlarmManager>()));
  return get;
}

class _$AppModule extends _i14.AppModule {}
