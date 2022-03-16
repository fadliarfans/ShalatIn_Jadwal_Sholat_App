class DateModel {
  int? timestamp;
  String? gregorian;
  String? hijri;

  DateModel(
      {required this.timestamp, required this.gregorian, required this.hijri});

  DateModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    gregorian = json['gregorian'];
    hijri = json['hijri'];
  }
}
