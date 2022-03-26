import 'package:flutter/material.dart';
import '../../theme.dart';

import '../main/main_page.dart';

class BoardingPage extends StatelessWidget {
  const BoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/boarding.png"),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 150),
              child: Text(
                "Jagalah Sholatmu Sesibuk Apapun Kamu",
                style: kWhite2TextStyle.copyWith(
                    fontSize: 34, fontWeight: bold, letterSpacing: -2),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: Text(
                "Aktifkan Notifikasi untuk menadapatkan Remainder pada waktu sholat",
                style:
                    kWhiteTextStyle.copyWith(fontWeight: medium, fontSize: 13),
              ),
            ),
            const Spacer(),
            Container(
              height: 52,
              margin: const EdgeInsets.only(left: 52, right: 52, bottom: 52),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const MainPage())));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22))),
                  child: Center(
                    child: Text(
                      'Masuk',
                      style: kWhiteTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 19),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
