import 'package:flutter/material.dart';

import '../../../theme.dart';

class JadwalErrorPage extends StatelessWidget {
  const JadwalErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/icon_map.png",
          height: 100,
        ),
        RichText(
          text: TextSpan(
            text: 'Location',
            style:
                kBlack2TextStyle.copyWith(fontWeight: semiBold, fontSize: 14),
            children: <TextSpan>[
              TextSpan(
                  text: ' Error',
                  style: kBlack2TextStyle.copyWith(
                      fontWeight: regular, fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}
