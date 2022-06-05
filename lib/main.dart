import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jadwal_sholat_app/cubit/niat/niat_cubit.dart';
import 'package:jadwal_sholat_app/theme.dart';
import 'package:jadwal_sholat_app/view/main/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/page/page_bloc.dart';
import 'data/repository/local/database/object_box.dart';
import 'injection.dart';
import 'view/boarding/boarding_page.dart';

import 'bloc/alarm/alarm_bloc.dart';
import 'bloc/jadwal/jadwal_bloc.dart';

ObjectBox? objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await configureDependencies();
  objectbox = await ObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isFirstTime;
  @override
  void initState() {
    super.initState();
    final prefs = locator<SharedPreferences>();
    isFirstTime = prefs.get('isFirstTime') as bool?;

    if (isFirstTime == null) {
      prefs.setBool("isFirstTime", true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageBloc(),
        ),
        BlocProvider(
          create: (context) => locator<JadwalBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<AlarmBloc>(),
        ),
        BlocProvider(
          create: (context) => NiatCubit(),
        ),
      ],
      child: MaterialApp(
        color: green,
        title: 'ShalatIn',
        home: isFirstTime == null ? const BoardingPage() : const MainPage(),
      ),
    );
  }
}
