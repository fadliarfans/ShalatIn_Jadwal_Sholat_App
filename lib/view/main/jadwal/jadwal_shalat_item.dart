import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/theme.dart';

class JadwalShalatItem extends StatelessWidget {
  const JadwalShalatItem(
      {Key? key, required this.title, required this.time, required this.isTrue})
      : super(key: key);
  final String title;
  final String time;
  final bool isTrue;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              title,
              style: kBlackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              time,
              style:
                  kBlack2TextStyle.copyWith(fontSize: 19, fontWeight: semiBold),
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Center(
                child: Switch(
              value: isTrue,
              onChanged: (value) {},
              activeColor: green,
            )))
      ],
    );
  }
}
