import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/shared/navigation_item.dart';
import 'package:jadwal_sholat_app/theme.dart';

class BottomNavigtionBar extends StatelessWidget {
  const BottomNavigtionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 77,
      decoration: BoxDecoration(
          color: white,
          boxShadow: const [
            BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 10,
                color: Colors.black12)
          ],
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          NavigationItem(
            title: "Beranda",
            image: "assets/images/icon_home.png",
          ),
          NavigationItem(
            title: "Jadwal Sholat",
            image: "assets/images/icon_clock.png",
          ),
          NavigationItem(
            title: "Inspirasi",
            image: "assets/images/icon_artikel.png",
          ),
          NavigationItem(
            title: "Tentang",
            image: "assets/images/icon_info.png",
          ),
        ],
      ),
    );
  }
}
