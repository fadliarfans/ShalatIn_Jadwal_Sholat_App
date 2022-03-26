import 'package:flutter/material.dart';
import '../../../theme.dart';
import '../../qiblah/qiblah_page.dart';

class HomeCenterButton extends StatelessWidget {
  const HomeCenterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 24, right: 24, top: 20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
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
            margin: const EdgeInsets.symmetric(vertical: 7),
          ),
          SizedBox(
            height: 94,
            width: 109,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const QiblahPage())));
                },
                icon: Image.asset(
                  "assets/images/kiblat.png",
                )),
          )
        ],
      ),
    );
  }
}
