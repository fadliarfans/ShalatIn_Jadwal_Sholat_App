import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/data/models/shalat_model.dart';
import 'package:jadwal_sholat_app/view/niat/niat_content_item.dart';
import 'package:jadwal_sholat_app/view/niat/niat_map.dart';

class NiatContent extends StatelessWidget {
  const NiatContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = niatMap[Shalat.Subuh]
            ?.map((e) => NiatContentItem(niatModel: e))
            .toList() ??
        [];
    return Column(
      children: [...list],
    );
  }
}
