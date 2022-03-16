import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/shared/inspiration_item.dart';
import 'package:jadwal_sholat_app/theme.dart';

class HomeInspiration extends StatelessWidget {
  const HomeInspiration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 23, left: 24),
            child: Text(
              "Inspirasi Hari Ini",
              style: kBlackTextStyle.copyWith(fontSize: 14, fontWeight: bold),
            ),
          ),
          const InspirationItem(image: "assets/images/inspiration_1.png"),
          const SizedBox(
            height: 14,
          ),
          const InspirationItem(image: "assets/images/inspiration_2.png"),
          const SizedBox(
            height: 14,
          ),
          const InspirationItem(image: "assets/images/inspiration_3.png"),
          const SizedBox(
            height: 140,
          ),
        ],
      ),
    );
  }
}