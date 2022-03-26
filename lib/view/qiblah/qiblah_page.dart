import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

import '../../shared/custom_circular_progress_indicator.dart';
import 'qiblah_compass.dart';

class QiblahPage extends StatefulWidget {
  const QiblahPage({Key? key}) : super(key: key);

  @override
  State<QiblahPage> createState() => _QiblahPageState();
}

class _QiblahPageState extends State<QiblahPage> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _deviceSupport,
        builder: (_, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );
          }

          return const QiblahCompass();
        },
      ),
    );
  }
}
