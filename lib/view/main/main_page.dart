import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/shared/bottom_navigation_bar.dart';
import 'package:jadwal_sholat_app/theme.dart';
import 'package:jadwal_sholat_app/view/main/home/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: semiWhite,
      body: Stack(
        children: const [
          HomePage(),
          Positioned(
              bottom: 47, left: 24, right: 24, child: BottomNavigtionBar())
        ],
      ),
    );
  }
}
