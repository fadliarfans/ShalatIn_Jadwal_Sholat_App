import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/theme.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem({required this.image, required this.title, Key? key})
      : super(key: key);
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                image,
                height: 30,
                color: green,
              )),
          Text(
            title,
            style: kBlackTextStyle.copyWith(
              fontSize: 10,
            ),
          )
        ],
      ),
    );
  }
}
