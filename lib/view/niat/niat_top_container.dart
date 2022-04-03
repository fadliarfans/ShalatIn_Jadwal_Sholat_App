import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jadwal_sholat_app/theme.dart';
import 'package:jadwal_sholat_app/view/niat/niat_choose_item.dart';

import '../../cubit/niat/niat_cubit.dart';
import '../../data/models/shalat_model.dart';

class NiatTopContainer extends StatefulWidget {
  const NiatTopContainer({Key? key}) : super(key: key);

  @override
  State<NiatTopContainer> createState() => _NiatTopContainerState();
}

class _NiatTopContainerState extends State<NiatTopContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 24,
                )),
            const SizedBox(
              width: 22,
            ),
            Text(
              "Niat Sholat",
              style:
                  kBlackTextStyle.copyWith(fontSize: 19, fontWeight: semiBold),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 30,
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<NiatCubit, NiatState>(
            builder: (context, state) {
              if (state is NiatChoosed) {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    NiatChooseItem(choosed: state.shalat, shalat: Shalat.Subuh),
                    NiatChooseItem(
                        choosed: state.shalat, shalat: Shalat.Dzuhur),
                    NiatChooseItem(choosed: state.shalat, shalat: Shalat.Ashar),
                    NiatChooseItem(
                        choosed: state.shalat, shalat: Shalat.Maghrib),
                    NiatChooseItem(choosed: state.shalat, shalat: Shalat.Isya),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        )
      ],
    );
  }
}
