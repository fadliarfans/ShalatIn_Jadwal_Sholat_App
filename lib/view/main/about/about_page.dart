import 'package:flutter/material.dart';

import '../../../theme.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    const box = SizedBox(
      height: 16,
    );
    const box2 = SizedBox(
      height: 8,
    );
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 54,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tentang Aplikasi",
                style: kBlackTextStyle.copyWith(
                    fontSize: 19, fontWeight: semiBold),
              ),
            ),
            box,
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo.png',
                width: 180,
                height: 180,
              ),
            ),
            box,
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(15)),
              child: Text(
                'Aplikasi pengingat sholat dengan memberikan notifikasi kepada pengguna, disertai dengan informasi waktu sholat, arah kiblat, doa niat shalat dan kata-kata inspirasi.',
                style:
                    kBlack2TextStyle.copyWith(fontWeight: medium, fontSize: 12),
              ),
            ),
            box,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sumber Data',
                style: kBlackTextStyle.copyWith(
                    fontWeight: semiBold, fontSize: 13),
              ),
            ),
            box,
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(24)),
              child: Text(
                'api.myquran.com',
                style: kBlack2TextStyle.copyWith(fontSize: 12),
              ),
            ),
            box,
            Text(
              'Sumber Gambar',
              style:
                  kBlackTextStyle.copyWith(fontWeight: semiBold, fontSize: 13),
            ),
            box,
            Container(
                padding: const EdgeInsets.all(24),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Inspiration Image',
                      style: kBlack2TextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 12),
                    ),
                    box,
                    Text(
                      'Image by Bonip',
                      style: kBlack2TextStyle.copyWith(
                          fontSize: 12, color: green, fontWeight: medium),
                    ),
                    Text(
                      'id.pinterest.com/pin/27092035247945938',
                      style: kBlack2TextStyle.copyWith(fontSize: 12),
                    ),
                    box2,
                    Text(
                      'Image by This Your Daily Motivation',
                      style: kBlack2TextStyle.copyWith(
                          fontSize: 12, color: green, fontWeight: medium),
                    ),
                    Text(
                      'id.pinterest.com/pin/99219998029890755',
                      style: kBlack2TextStyle.copyWith(fontSize: 12),
                    ),
                    box2,
                    Text(
                      'Image by MIM',
                      style: kBlack2TextStyle.copyWith(
                          fontSize: 12, color: green, fontWeight: medium),
                    ),
                    Text(
                      'id.pinterest.com/pin/46091596175437450',
                      style: kBlack2TextStyle.copyWith(fontSize: 12),
                    ),
                    box2,
                    Text(
                      'Image by Numpy',
                      style: kBlack2TextStyle.copyWith(
                          fontSize: 12, color: green, fontWeight: medium),
                    ),
                    Text(
                      'id.pinterest.com/pin/3237030972440831',
                      style: kBlack2TextStyle.copyWith(fontSize: 12),
                    ),
                    box2,
                    Text(
                      'Image by Ruang Edit',
                      style: kBlack2TextStyle.copyWith(
                          fontSize: 12, color: green, fontWeight: medium),
                    ),
                    Text(
                      'id.pinterest.com/pin/8444318042634893',
                      style: kBlack2TextStyle.copyWith(fontSize: 12),
                    ),
                    box2,
                    Text(
                      'Image by MIM',
                      style: kBlack2TextStyle.copyWith(
                          fontSize: 12, color: green, fontWeight: medium),
                    ),
                    Text(
                      'id.pinterest.com/pin/1900024834688555',
                      style: kBlack2TextStyle.copyWith(fontSize: 12),
                    ),
                    box2,
                    Text(
                      'Image by Chaaa',
                      style: kBlack2TextStyle.copyWith(
                          fontSize: 12, color: green, fontWeight: medium),
                    ),
                    Text(
                      'id.pinterest.com/pin/70437482016626',
                      style: kBlack2TextStyle.copyWith(fontSize: 12),
                    ),
                    box2,
                    Text(
                      'Image by Yarmolikh',
                      style: kBlack2TextStyle.copyWith(
                          fontSize: 12, color: green, fontWeight: medium),
                    ),
                    Text(
                      'id.pinterest.com/pin/87186942775169177',
                      style: kBlack2TextStyle.copyWith(fontSize: 12),
                    ),
                    box2,
                    Text(
                      'Image By Miim',
                      style: kBlack2TextStyle.copyWith(
                          fontSize: 12, color: green, fontWeight: medium),
                    ),
                    Text(
                      'id.pinterest.com/pin/15762667436593646',
                      style: kBlack2TextStyle.copyWith(fontSize: 12),
                    ),
                    box2,
                  ],
                )),
            box,
            Container(
                padding: const EdgeInsets.all(24),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Asset Image',
                      style: kBlack2TextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 12),
                    ),
                    box,
                    Text(
                      'Masjid Image by Juan Camilo Guarin P',
                      style: kBlack2TextStyle.copyWith(
                          fontSize: 12, color: green, fontWeight: medium),
                    ),
                    Text(
                      'unsplash.com/photos/njEXjDmYn8w',
                      style: kBlack2TextStyle.copyWith(fontSize: 12),
                    ),
                    box2,
                    Text(
                      'Masjid Image by Fahrul Azmi',
                      style: kBlack2TextStyle.copyWith(
                          fontSize: 12, color: green, fontWeight: medium),
                    ),
                    Text(
                      'unsplash.com/photos/gyKmF0vnfBs',
                      style: kBlack2TextStyle.copyWith(fontSize: 12),
                    ),
                    box2,
                  ],
                )),
            box,
            Container(
                padding: const EdgeInsets.all(24),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Icon',
                      style: kBlack2TextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 12),
                    ),
                    box,
                    Text(
                      'Icon by FreeEpik',
                      style: kBlack2TextStyle.copyWith(
                          fontSize: 12, color: green, fontWeight: medium),
                    ),
                    Text(
                      'freepik.com',
                      style: kBlack2TextStyle.copyWith(fontSize: 12),
                    ),
                    box2,
                    Text(
                      'Icon by amonrat rungreangfangsai',
                      style: kBlack2TextStyle.copyWith(
                          fontSize: 12, color: green, fontWeight: medium),
                    ),
                    Text(
                      'flaticon.com',
                      style: kBlack2TextStyle.copyWith(fontSize: 12),
                    ),
                    box2,
                  ],
                )),
            box,
            Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '@ 2022 ',
                            style: kBlack3TextStyle.copyWith(
                                fontWeight: medium, fontSize: 12)),
                        TextSpan(
                            text: 'Nasgor Dev',
                            style: kBlack3TextStyle.copyWith(
                                fontWeight: semiBold,
                                fontSize: 12,
                                color: green)),
                      ],
                    ),
                  ),
                )),
            const SizedBox(
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}
