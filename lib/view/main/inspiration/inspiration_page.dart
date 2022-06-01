import 'package:flutter/material.dart';
import '../../../theme.dart';

import '../../../shared/inspiration_item.dart';

class InspirationPage extends StatelessWidget {
  const InspirationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 54,
            ),
            Text(
              "Inspirasi",
              style:
                  kBlackTextStyle.copyWith(fontWeight: semiBold, fontSize: 19),
            ),
            const SizedBox(
              height: 12,
            ),
            const InspirationItem(image: "assets/images/inspiration_9.png"),
            const InspirationItem(image: "assets/images/inspiration_7.png"),
            const InspirationItem(image: "assets/images/inspiration_6.png"),
            const InspirationItem(image: "assets/images/inspiration_5.png"),
            const InspirationItem(image: "assets/images/inspiration_4.png"),
            const InspirationItem(image: "assets/images/inspiration_3.png"),
            const InspirationItem(image: "assets/images/inspiration_2.png"),
            const InspirationItem(image: "assets/images/inspiration_1.png"),
            const InspirationItem(image: "assets/images/inspiration_8.png"),
            const SizedBox(
              height: 140,
            )
          ],
        ),
      ),
    );
  }
}
