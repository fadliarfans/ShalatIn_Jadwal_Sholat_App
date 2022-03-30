import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jadwal_sholat_app/service/notification/notification_manager.dart';
import 'bloc/page/page_bloc.dart';
import 'view/boarding/boarding_page.dart';

import 'bloc/alarm/alarm_bloc.dart';
import 'bloc/jadwal/jadwal_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    NotificationManager();
    super.initState();
    AndroidAlarmManager.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageBloc(),
        ),
        BlocProvider(
          create: (context) => JadwalBloc(),
        ),
        BlocProvider(
          create: (context) => AlarmBloc(),
        ),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: BoardingPage(),
      ),
    );
  }
}
