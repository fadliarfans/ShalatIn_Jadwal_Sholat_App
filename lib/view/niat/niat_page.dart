import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jadwal_sholat_app/cubit/niat/niat_cubit.dart';
import 'package:jadwal_sholat_app/data/models/shalat_model.dart';
import 'package:jadwal_sholat_app/view/niat/niat_content.dart';
import 'package:jadwal_sholat_app/view/niat/niat_top_container.dart';

class NiatPage extends StatelessWidget {
  const NiatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NiatCubit>(context).chooseNiat(Shalat.Subuh);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 54),
          child: Column(
            children: const [
              NiatTopContainer(),
              SizedBox(
                height: 16,
              ),
              NiatContent()
            ],
          ),
        ),
      ),
    );
  }
}
