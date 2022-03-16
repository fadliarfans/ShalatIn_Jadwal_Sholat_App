import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jadwal_sholat_app/bloc/page_bloc.dart';
import 'package:jadwal_sholat_app/view/boarding/boarding_page.dart';

import 'bloc/jadwal_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: BoardingPage(),
      ),
    );
  }
}
