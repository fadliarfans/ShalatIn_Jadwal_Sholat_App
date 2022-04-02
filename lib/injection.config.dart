// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'bloc/jadwal/jadwal_bloc.dart' as _i10;
import 'data/repository/local/local_data_source.dart' as _i8;
import 'data/repository/local/shared_preference/cache.dart' as _i4;
import 'data/repository/local/shared_preference/jadwal_dao.dart' as _i5;
import 'data/repository/local/shared_preference/location_dao.dart' as _i6;
import 'data/repository/remote/api_service.dart' as _i3;
import 'data/repository/remote/remote_data_source.dart' as _i7;
import 'data/repository/repository_dart.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ApiService>(() => _i3.ApiService());
  gh.factory<_i4.Cache>(() => _i4.Cache());
  gh.factory<_i5.JadwalDao>(() => _i5.JadwalDao(get<_i4.Cache>()));
  gh.factory<_i6.LocationDao>(() => _i6.LocationDao(get<_i4.Cache>()));
  gh.factory<_i7.RemoteDataSource>(
      () => _i7.RemoteDataSource(get<_i3.ApiService>()));
  gh.factory<_i8.LocalDataSource>(
      () => _i8.LocalDataSource(get<_i6.LocationDao>(), get<_i5.JadwalDao>()));
  gh.factory<_i9.Repository>(() =>
      _i9.Repository(get<_i8.LocalDataSource>(), get<_i7.RemoteDataSource>()));
  gh.factory<_i10.JadwalBloc>(() => _i10.JadwalBloc(get<_i9.Repository>()));
  return get;
}
