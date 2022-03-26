import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/alarm/alarm_bloc.dart';
import '../../../theme.dart';
import '../../../data/shalat_model.dart';

class JadwalShalatItem extends StatefulWidget {
  const JadwalShalatItem({Key? key, required this.shalat, required this.time})
      : super(key: key);
  final Shalat shalat;
  final String time;

  @override
  State<JadwalShalatItem> createState() => _JadwalShalatItemState();
}

class _JadwalShalatItemState extends State<JadwalShalatItem> {
  var isOn = false;

  turnOffOrOn() {
    setState(() {
      isOn = !isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              widget.shalat.name,
              style: kBlackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              widget.time,
              style:
                  kBlack2TextStyle.copyWith(fontSize: 19, fontWeight: semiBold),
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Center(
                child: Switch(
              value: isOn,
              onChanged: (value) {
                turnOffOrOn();
                if (isOn) {
                  BlocProvider.of<AlarmBloc>(context)
                      .add(LaunchAlarmOnTime(widget.shalat));
                } else {
                  BlocProvider.of<AlarmBloc>(context)
                      .add(CancelAlarmOnTime(widget.shalat));
                }
              },
              activeColor: green,
            )))
      ],
    );
  }
}
