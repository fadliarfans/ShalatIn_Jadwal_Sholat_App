import 'package:flutter/material.dart';
import 'home_app_bar.dart';
import 'home_center_button.dart';
import 'home_inspiration.dart';
import 'home_ongoing_time.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: const [
        HomeAppBar(),
        HomeOnGoingTime(),
        HomeCenterButton(),
        HomeInspiration()
      ],
    ));
  }
}
