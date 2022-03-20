import 'package:flutter/material.dart';

import '../../../theme.dart';

class HomeTimerShalat extends StatefulWidget {
  const HomeTimerShalat(
      {required this.jadwalHour, required this.jadwalMinute, Key? key})
      : super(key: key);
  final int jadwalHour;
  final int jadwalMinute;
  @override
  State<HomeTimerShalat> createState() => _HomeTimerShalatState();
}

class _HomeTimerShalatState extends State<HomeTimerShalat>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  initTimer() {
    if (_controller.status != AnimationStatus.dismissed) {
      _controller.stop();
    }
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;
    final second = now.second;
    var leftHour = 0;
    var leftMinute = 0;
    var leftSecond = 0;
    if (hour <= widget.jadwalHour) {
      leftHour = widget.jadwalHour - hour;
    } else {
      leftHour = 24 + widget.jadwalHour - hour;
    }
    if (minute <= widget.jadwalMinute) {
      leftMinute = widget.jadwalMinute - minute;
    } else {
      leftHour--;
      leftMinute = 60 + widget.jadwalMinute - minute;
    }
    leftSecond = 60 - second;
    // i subtract it because already become second
    leftMinute--;
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            hours: leftHour, minutes: leftMinute, seconds: leftSecond));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get getTimeCountDown {
    Duration duration = (_controller.duration ?? const Duration(seconds: 0)) *
        (1 - _controller.value);
    return "${(duration.inHours % 24).toString().padLeft(2, "0")} : ${(duration.inMinutes % 60).toString().padLeft(2, "0")} : ${(duration.inSeconds % 60).toString().padLeft(2, "0")}";
  }

  @override
  Widget build(BuildContext context) {
    initTimer();
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Text(
            getTimeCountDown,
            style: kWhiteTextStyle.copyWith(fontSize: 13, fontWeight: regular),
          );
        });
  }
}
