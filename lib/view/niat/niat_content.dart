import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jadwal_sholat_app/cubit/niat/niat_cubit.dart';
import 'package:jadwal_sholat_app/view/niat/niat_content_item.dart';
import 'package:jadwal_sholat_app/view/niat/niat_map.dart';

class NiatContent extends StatelessWidget {
  const NiatContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NiatCubit, NiatState>(
      builder: (context, state) {
        if (state is NiatChoosed) {
          final list = niatMap[state.shalat]
                  ?.map((e) => NiatContentItem(niatModel: e))
                  .toList() ??
              [];
          return Column(
            children: [...list],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
