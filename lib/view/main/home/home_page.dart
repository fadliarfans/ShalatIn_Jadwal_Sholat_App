import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/theme.dart';
import 'package:jadwal_sholat_app/view/main/home/home_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: semiWhite,
      body: Column(
        children: [const HomeAppBar()],
      ),
    );
  }
}
