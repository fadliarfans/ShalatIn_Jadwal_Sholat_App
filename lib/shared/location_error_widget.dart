import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/theme.dart';

class LocationErrorWidget extends StatelessWidget {
  final String? error;
  final Function? callback;

  const LocationErrorWidget({Key? key, this.error, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const box = SizedBox(height: 32);
    const errorColor = green;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.location_off,
            size: 150,
            color: errorColor,
          ),
          box,
          Text(
            error!,
            style: kBlackTextStyle,
          ),
          box,
          Material(
            borderRadius: BorderRadius.circular(80),
            color: white,
            child: InkWell(
              onTap: () {
                if (callback != null) callback!();
              },
              splashColor: green,
              borderRadius: BorderRadius.circular(80),
              child: Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: const Icon(
                  Icons.refresh,
                  color: green,
                  size: 30,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
