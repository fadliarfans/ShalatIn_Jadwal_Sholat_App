import 'package:flutter/material.dart';
import '../../../theme.dart';

import '../../../shared/inspiration_item.dart';

class InspirationPage extends StatelessWidget {
  const InspirationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 54, left: 24, right: 24),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Inspirasi",
                style: kBlackTextStyle.copyWith(
                    fontWeight: semiBold, fontSize: 19),
              )
            ],
          ),
          Expanded(
              child: ListView(
            children: const [
              InspirationItem(image: "assets/images/inspiration_9.png"),
              InspirationItem(image: "assets/images/inspiration_8.png"),
              InspirationItem(image: "assets/images/inspiration_7.png"),
              InspirationItem(image: "assets/images/inspiration_6.png"),
              InspirationItem(image: "assets/images/inspiration_5.png"),
              InspirationItem(image: "assets/images/inspiration_4.png"),
              InspirationItem(image: "assets/images/inspiration_3.png"),
              InspirationItem(image: "assets/images/inspiration_2.png"),
              InspirationItem(image: "assets/images/inspiration_1.png"),
              SizedBox(
                height: 140,
              )
            ],
          ))
        ],
      ),
    );
  }
}
