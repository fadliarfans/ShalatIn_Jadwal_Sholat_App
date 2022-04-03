import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jadwal_sholat_app/cubit/niat/niat_cubit.dart';
import 'package:jadwal_sholat_app/theme.dart';

import '../../data/models/shalat_model.dart';

class NiatChooseItem extends StatelessWidget {
  final Shalat choosed;
  final Shalat shalat;

  const NiatChooseItem({Key? key, required this.choosed, required this.shalat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<NiatCubit>(context).chooseNiat(shalat);
      },
      child: Container(
        height: 30,
        width: 73,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: shalat == choosed ? green : white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            shalat.name,
            style: kWhiteTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 12,
                color: shalat == choosed ? white : green),
          ),
        ),
      ),
    );
  }
}
