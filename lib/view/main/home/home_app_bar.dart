import 'package:flutter/material.dart';

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
            onPressed: () {},
            icon: Image.asset(
              "assets/images/icon_menu.png",
              height: 30,
            ),
          ),
          Row(
            children: [
              Image.asset(
                "assets/images/icon_map.png",
                height: 16,
              ),
              Text(
                " Jakarta, ",
                style: kBlack2TextStyle.copyWith(
                    fontSize: 13, fontWeight: semiBold),
              ),
              Text(
                "Indonesia",
                style: kBlack2TextStyle.copyWith(
                    fontSize: 13, fontWeight: regular),
              ),
            ],
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