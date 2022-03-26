class Time {
  int hour = 0;
  int minute = 0;
  final String timeS;
  Time(this.timeS) {
    hour = int.parse(timeS.substring(0, 2));
    minute = int.parse(timeS.substring(3, 5));
  }
}
