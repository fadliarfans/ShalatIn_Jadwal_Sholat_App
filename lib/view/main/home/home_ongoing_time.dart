import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../theme.dart';
import 'home_timer_sholat.dart';

import '../../../bloc/jadwal/jadwal_bloc.dart';

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
                    state.dateId,
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
                          state.nextJadwal.shalat.name,
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
                              state.nextJadwal.time,
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
                            HomeTimerShalat(
                              jadwalHour: state.nextJadwal.hour,
                              jadwalMinute: state.nextJadwal.minute,
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
          return Container();
        }
      },
    );
  }
}
