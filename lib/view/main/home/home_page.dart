import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/theme.dart';
import 'package:jadwal_sholat_app/view/main/home/home_app_bar.dart';
import 'package:jadwal_sholat_app/view/main/home/home_center_button.dart';
import 'package:jadwal_sholat_app/view/main/home/home_inspiration.dart';
import 'package:jadwal_sholat_app/view/main/home/home_ongoing_time.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: semiWhite,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HomeAppBar(),
            HomeOnGoingTime(),
            HomeCenterButton(),
            HomeInspiration()
          ],
        ),
      ),
    );
  }
}
