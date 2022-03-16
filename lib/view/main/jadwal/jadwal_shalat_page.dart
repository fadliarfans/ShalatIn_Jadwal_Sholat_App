import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/view/main/jadwal/jadwal_shalat_center_container.dart';
import 'package:jadwal_sholat_app/view/main/jadwal/jadwal_sholat_top_container.dart';

class JadwalShalatPage extends StatelessWidget {
  const JadwalShalatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: const [
            JadwalSholatTopContainer(),
            JadwalSholatCenterContainer(),
            SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }
}
