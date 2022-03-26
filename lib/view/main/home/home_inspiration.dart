import 'package:flutter/material.dart';
import '../../../shared/inspiration_item.dart';
import '../../../theme.dart';

class HomeInspiration extends StatelessWidget {
  const HomeInspiration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 19),
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 23),
              child: Text(
                "Inspirasi Hari Ini",
                style: kBlackTextStyle.copyWith(fontSize: 14, fontWeight: bold),
              ),
            ),
            const InspirationItem(image: "assets/images/inspiration_1.png"),
            const InspirationItem(image: "assets/images/inspiration_2.png"),
            const InspirationItem(image: "assets/images/inspiration_3.png"),
            const SizedBox(
              height: 140,
            ),
          ],
        ),
      ),
    );
  }
}
