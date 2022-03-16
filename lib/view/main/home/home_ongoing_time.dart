import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jadwal_sholat_app/theme.dart';

import '../../../bloc/jadwal_bloc.dart';

class HomeOnGoingTime extends StatelessWidget {
  const HomeOnGoingTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JadwalBloc, JadwalState>(
      builder: (context, state) {
        if (state is JadwalSucces) {
          return Container(
            margin: const EdgeInsets.only(top: 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    "Minggu, 13 Maret 2022",
                    style: kBlackTextStyle.copyWith(fontSize: 13),
                  ),
                ),
                Container(
                  height: 166,
                  margin: const EdgeInsets.only(left: 24, right: 24, top: 16),
                  padding: const EdgeInsets.only(left: 22),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/home_1.png"),
                          fit: BoxFit.cover)),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 34,
                        ),
                        Text(
                          "Maghrib",
                          style: kWhiteTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 19,
                              letterSpacing: 1),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "18:10",
                              style: kWhiteTextStyle.copyWith(
                                  fontSize: 36,
                                  fontWeight: bold,
                                  letterSpacing: 5),
                            ),
                            Text(
                              "  WIB",
                              style: kWhiteTextStyle.copyWith(
                                  fontSize: 14, fontWeight: semiBold),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        Row(
                          children: [
                            Text(
                              "00:02:00",
                              style: kWhiteTextStyle.copyWith(
                                  fontSize: 13, fontWeight: regular),
                            ),
                            Text(" Menuju Waktu Sholat",
                                style: kWhiteTextStyle.copyWith(
                                    fontSize: 13, fontWeight: regular))
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
