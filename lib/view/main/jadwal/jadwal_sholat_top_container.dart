import 'package:flutter/material.dart';

import '../../../theme.dart';

class JadwalSholatTopContainer extends StatelessWidget {
  const JadwalSholatTopContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 54),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              "Jadwal Sholat",
              style:
                  kBlackTextStyle.copyWith(fontSize: 19, fontWeight: semiBold),
            ),
          ),
          Container(
            height: 206,
            margin: const EdgeInsets.only(left: 24, right: 24, top: 16),
            padding: const EdgeInsets.only(left: 22),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                    image: AssetImage("assets/images/jadwal_sholat_1.png"),
                    fit: BoxFit.cover)),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 39,
                  ),
                  Image.asset(
                    "assets/images/icon_bell.png",
                    height: 30,
                    color: white,
                    width: 30,
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    "18:12",
                    style: kWhiteTextStyle.copyWith(
                        fontSize: 36, fontWeight: bold, letterSpacing: 5),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Maghrib",
                    style: kWhiteTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 19, letterSpacing: 1),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Minggu, 13 Maret 2022",
                    style: kWhiteTextStyle.copyWith(
                        fontSize: 13, fontWeight: regular),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
