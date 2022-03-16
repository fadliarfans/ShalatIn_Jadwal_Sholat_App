import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jadwal_sholat_app/bloc/page_bloc.dart';
import 'package:jadwal_sholat_app/shared/navigation_item.dart';
import 'package:jadwal_sholat_app/theme.dart';

class BottomNavigtionBar extends StatelessWidget {
  const BottomNavigtionBar({required this.index, Key? key}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 77,
      decoration: BoxDecoration(
          color: white,
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 0), blurRadius: 10, color: Colors.black12)
          ],
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavigationItem(
            title: "Beranda",
            image: "assets/images/icon_home.png",
            color: index == 1 ? green : grey,
            callback: () {
              BlocProvider.of<PageBloc>(context).add(ToHome());
            },
          ),
          NavigationItem(
            title: "Jadwal Sholat",
            image: "assets/images/icon_clock.png",
            color: index == 2 ? green : grey,
            callback: () {
              BlocProvider.of<PageBloc>(context).add(ToJadwalShalat());
            },
          ),
          NavigationItem(
            title: "Inspirasi",
            image: "assets/images/icon_artikel.png",
            color: index == 3 ? green : grey,
            callback: () {
              BlocProvider.of<PageBloc>(context).add(ToInspiration());
            },
          ),
          NavigationItem(
            title: "Tentang",
            image: "assets/images/icon_info.png",
            color: index == 4 ? green : grey,
            callback: () {
              BlocProvider.of<PageBloc>(context).add(ToAbout());
            },
          ),
        ],
      ),
    );
  }
}
