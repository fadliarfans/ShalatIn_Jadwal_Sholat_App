import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jadwal_sholat_app/theme.dart';
import 'package:jadwal_sholat_app/view/main/jadwal/jadwal_shalat_item.dart';

import '../../../bloc/jadwal_bloc.dart';

class JadwalSholatCenterContainer extends StatelessWidget {
  const JadwalSholatCenterContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JadwalBloc, JadwalState>(
      builder: (context, state) {
        if (state is JadwalSucces) {
          final times = state.jadwal.listDateTime?.first.times;

          return Container(
            margin: const EdgeInsets.only(left: 24, right: 24, top: 27),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          "assets/images/icon_calendar.png",
                          height: 30,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          "assets/images/icon_clock.png",
                          height: 30,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          "assets/images/icon_bell.png",
                          height: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                JadwalShalatItem(
                  title: "Subuh",
                  time: times?.fajr ?? "",
                  isTrue: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                JadwalShalatItem(
                  title: "Dzuhur",
                  time: times?.dhuhr ?? "",
                  isTrue: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                JadwalShalatItem(
                  title: "Ashar",
                  time: times?.asr ?? "",
                  isTrue: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                JadwalShalatItem(
                  title: "Maghrib",
                  time: times?.maghrib ?? "",
                  isTrue: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                JadwalShalatItem(
                  title: "Isya",
                  time: times?.isha ?? "",
                  isTrue: false,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        } else {
          return const SizedBox(
            height: 500,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
