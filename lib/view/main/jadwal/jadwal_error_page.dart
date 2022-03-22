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
            text: '  Something',
            style:
                kBlack2TextStyle.copyWith(fontWeight: semiBold, fontSize: 13),
            children: <TextSpan>[
              TextSpan(
                  text: ' Error Happened',
                  style: kBlack2TextStyle.copyWith(
                      fontWeight: regular, fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }
}
