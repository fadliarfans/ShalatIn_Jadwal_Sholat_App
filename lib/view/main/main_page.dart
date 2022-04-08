import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/alarm/alarm_bloc.dart';
import '../../bloc/jadwal/jadwal_bloc.dart';
import '../../bloc/page/page_bloc.dart';
import '../../shared/bottom_navigation_bar.dart';
import '../../shared/bottom_sheet_choose_city.dart';
import '../../theme.dart';
import 'home/home_page.dart';
import 'inspiration/inspiration_page.dart';

import 'about/about_page.dart';
import 'jadwal/jadwal_shalat_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PageBloc>(context).add(ToHome());
    BlocProvider.of<JadwalBloc>(context).add(GetJadwal());
    BlocProvider.of<AlarmBloc>(context).add(GetAlarm());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: semiWhite,
      body: BlocListener<JadwalBloc, JadwalState>(
        listener: (context, state) {
          if (state is JadwalChooseCity) {
            showBottomSheet(
                context: context,
                enableDrag: false,
                builder: (constext) {
                  return const BottomSheetChooseCity();
                });
          }
        },
        child: GestureDetector(
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
