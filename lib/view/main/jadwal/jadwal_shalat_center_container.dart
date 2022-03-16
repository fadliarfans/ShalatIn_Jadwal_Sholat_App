import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/theme.dart';
import 'package:jadwal_sholat_app/view/main/jadwal/jadwal_shalat_item.dart';

class JadwalSholatCenterContainer extends StatelessWidget {
  const JadwalSholatCenterContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          const JadwalShalatItem(
            title: "Subuh",
            time: "04:40",
            isTrue: false,
          ),
          const SizedBox(
            height: 20,
          ),
          const JadwalShalatItem(
            title: "Dzuhur",
            time: "12:05",
            isTrue: true,
          ),
          const SizedBox(
            height: 20,
          ),
          const JadwalShalatItem(
            title: "Ashar",
            time: "15:07",
            isTrue: false,
          ),
          const SizedBox(
            height: 20,
          ),
          const JadwalShalatItem(
            title: "Maghrib",
            time: "18:12",
            isTrue: false,
          ),
          const SizedBox(
            height: 20,
          ),
          const JadwalShalatItem(
            title: "Isya",
            time: "19:24",
            isTrue: false,
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
