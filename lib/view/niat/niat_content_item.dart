import 'package:flutter/cupertino.dart';
import 'package:jadwal_sholat_app/data/models/niat_model.dart';
import 'package:jadwal_sholat_app/theme.dart';

class NiatContentItem extends StatelessWidget {
  final NiatModel niatModel;

  const NiatContentItem({required this.niatModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 17),
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 19,
          ),
          Text(
            niatModel.role,
            style:
                kBlack2TextStyle.copyWith(fontWeight: semiBold, fontSize: 13),
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            niatModel.niat,
            style: kBlackTextStyle.copyWith(fontWeight: regular, fontSize: 18),
            textAlign: TextAlign.end,
          ),
          const SizedBox(
            height: 9,
          ),
          Text(
            niatModel.transliteration,
            style: kBlackTextStyle.copyWith(
                fontWeight: regular, fontSize: 12, fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            niatModel.translation,
            style: kBlackTextStyle.copyWith(
              fontWeight: regular,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 23,
          ),
        ],
      ),
    );
  }
}
