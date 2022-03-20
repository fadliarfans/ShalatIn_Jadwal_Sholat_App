import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jadwal_sholat_app/bloc/jadwal/jadwal_bloc.dart';
import 'package:jadwal_sholat_app/bloc/page/page_bloc.dart';
import 'package:jadwal_sholat_app/shared/bottom_navigation_bar.dart';
import 'package:jadwal_sholat_app/theme.dart';
import 'package:jadwal_sholat_app/view/main/home/home_page.dart';
import 'package:jadwal_sholat_app/view/main/inspiration/inspiration_page.dart';

import 'about/about_page.dart';
import 'jadwal/jadwal_shalat_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PageBloc>(context).add(ToHome());
    BlocProvider.of<JadwalBloc>(context).add(GetJadwal());
    return BlocListener<JadwalBloc, JadwalState>(
      listener: (context, state) {
        if (kDebugMode) {
          print(state);
        }
      },
      child: Scaffold(
        backgroundColor: semiWhite,
        body: GestureDetector(
          onHorizontalDragEnd: (details) {
            // Swiping in right direction.
            if ((details.primaryVelocity ?? 1) > 0) {
              BlocProvider.of<PageBloc>(context).add(ToLeft());
            }
            // Swiping in left direction.
            if ((details.primaryVelocity ?? 1) < 0) {
              BlocProvider.of<PageBloc>(context).add(ToRight());
            }
          },
          child: BlocBuilder<PageBloc, PageState>(
            builder: (context, state) {
              if (state is HomePage) {
                return Stack(
                  children: const [
                    HomePage(),
                    Positioned(
                        bottom: 47,
                        left: 24,
                        right: 24,
                        child: BottomNavigtionBar(
                          index: 1,
                        ))
                  ],
                );
              } else if (state is InspirationPageState) {
                return Stack(
                  children: const [
                    InspirationPage(),
                    Positioned(
                        bottom: 47,
                        left: 24,
                        right: 24,
                        child: BottomNavigtionBar(index: 3))
                  ],
                );
              } else if (state is JadwalShalatPageState) {
                return Stack(
                  children: const [
                    JadwalShalatPage(),
                    Positioned(
                        bottom: 47,
                        left: 24,
                        right: 24,
                        child: BottomNavigtionBar(
                          index: 2,
                        ))
                  ],
                );
              } else if (state is AboutPageState) {
                return Stack(
                  children: const [
                    AboutPage(),
                    Positioned(
                        bottom: 47,
                        left: 24,
                        right: 24,
                        child: BottomNavigtionBar(
                          index: 4,
                        ))
                  ],
                );
              } else {
                return Stack(
                  children: const [
                    HomePage(),
                    Positioned(
                        bottom: 47,
                        left: 24,
                        right: 24,
                        child: BottomNavigtionBar(
                          index: 1,
                        ))
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
