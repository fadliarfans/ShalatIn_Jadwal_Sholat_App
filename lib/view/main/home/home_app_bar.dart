import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/jadwal/jadwal_bloc.dart';
import '../../../shared/bottom_sheet_choose_city.dart';
import '../../../theme.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 24, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              showBottomSheet(
                  context: context,
                  builder: (constext) {
                    return const BottomSheetChooseCity();
                  });
            },
            icon: Image.asset(
              "assets/images/icon_menu.png",
              height: 30,
            ),
          ),
          BlocBuilder<JadwalBloc, JadwalState>(
            builder: (context, state) {
              if (state is JadwalSucces) {
                return Row(
                  children: [
                    Image.asset(
                      "assets/images/icon_map.png",
                      height: 16,
                    ),
                    Text(
                      "  ${state.location.city}",
                      style: kBlack2TextStyle.copyWith(
                          fontSize: 13, fontWeight: semiBold),
                    ),
                    // Text(
                    //   state.location.country.toString(),
                    //   style: kBlack2TextStyle.copyWith(
                    //       fontSize: 13, fontWeight: regular),
                    // ),
                  ],
                );
              } else if (state is JadwalLoading) {
                return Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: LinearProgressIndicator(
                    color: green,
                    backgroundColor: white,
                  ),
                ));
              } else {
                return GestureDetector(
                  onTap: () {
                    showBottomSheet(
                        context: context,
                        builder: (constext) {
                          return const BottomSheetChooseCity();
                        });
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/icon_map.png",
                        height: 16,
                      ),
                      RichText(
                        text: TextSpan(
                          text: '  Something',
                          style: kBlack2TextStyle.copyWith(
                              fontWeight: semiBold, fontSize: 13),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Error Happened',
                                style: kBlack2TextStyle.copyWith(
                                    fontWeight: regular, fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          Image.asset(
            "assets/images/kaaba.png",
            height: 50,
          ),
        ],
      ),
    );
  }
}
