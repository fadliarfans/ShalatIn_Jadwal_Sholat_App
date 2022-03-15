import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/theme.dart';

class HomeCenterButton extends StatelessWidget {
  const HomeCenterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114,
      width: double.infinity,
      margin: EdgeInsets.only(left: 24, right: 24, top: 20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 94,
            width: 109,
            child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/images/niat_shalat.png",
                )),
          ),
          Container(
            width: 1,
            color: green,
            margin: EdgeInsets.symmetric(vertical: 7),
          ),
          Container(
            height: 94,
            width: 109,
            child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/images/kiblat.png",
                )),
          )
        ],
      ),
    );
  }
}
