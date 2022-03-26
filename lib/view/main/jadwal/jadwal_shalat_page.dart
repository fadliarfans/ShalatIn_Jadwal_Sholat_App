import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/jadwal/jadwal_bloc.dart';
import '../../../shared/custom_circular_progress_indicator.dart';
import 'jadwal_error_page.dart';
import 'jadwal_shalat_center_container.dart';
import 'jadwal_sholat_top_container.dart';

class JadwalShalatPage extends StatelessWidget {
  const JadwalShalatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JadwalBloc, JadwalState>(
      builder: (context, state) {
        if (state is JadwalSucces) {
          return SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  JadwalSholatTopContainer(
                    state: state,
                  ),
                  JadwalSholatCenterContainer(
                    state: state,
                  ),
                  const SizedBox(
                    height: 150,
                  )
                ],
              ),
            ),
          );
        } else if (state is JadwalLoading) {
          return const Center(
            child: LoadingIndicator(),
          );
        } else {
          return const Center(child: JadwalErrorPage());
        }
      },
    );
  }
}
