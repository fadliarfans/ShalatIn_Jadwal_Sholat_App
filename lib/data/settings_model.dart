class SettingsModel {
  String? timeformat;
  String? school;
  String? juristic;
  String? highlat;
  double? fajrAngle;
  double? ishaAngle;

  SettingsModel(
      {required this.fajrAngle,
      required this.highlat,
      required this.ishaAngle,
      required this.juristic,
      required this.school,
      required this.timeformat});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    timeformat = json['timeformat'];
    school = json['school'];
    juristic = json['juristic'];
    highlat = json['highlat'];
    fajrAngle = json['fajr_angle'];
    ishaAngle = json['isha_angle'];
  }
}
