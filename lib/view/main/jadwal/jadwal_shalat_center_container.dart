import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/data/shalat_model.dart';
import 'package:jadwal_sholat_app/theme.dart';
import 'package:jadwal_sholat_app/view/main/jadwal/jadwal_shalat_item.dart';

import '../../../bloc/jadwal_bloc.dart';

class JadwalSholatCenterContainer extends StatelessWidget {
  const JadwalSholatCenterContainer({required this.state, Key? key})
      : super(key: key);
  final JadwalSucces state;
  @override
  Widget build(BuildContext context) {
    var times = state.jadwal.listDateTime?.first.times;
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 27),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(15)),
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
            shalat: Shalat.Subuh,
            time: times?.fajr ?? "",
          ),
          const SizedBox(
            height: 20,
          ),
          JadwalShalatItem(
            shalat: Shalat.Dzuhur,
            time: times?.dhuhr ?? "",
          ),
          const SizedBox(
            height: 20,
          ),
          JadwalShalatItem(
            shalat: Shalat.Ashar,
            time: times?.asr ?? "",
          ),
          const SizedBox(
            height: 20,
          ),
          JadwalShalatItem(
            shalat: Shalat.Maghrib,
            time: times?.maghrib ?? "",
          ),
          const SizedBox(
            height: 20,
          ),
          JadwalShalatItem(
            shalat: Shalat.Isya,
            time: times?.isha ?? "",
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
