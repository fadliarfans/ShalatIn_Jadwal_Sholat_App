class TimesModel {
  String? imsak;
  String? sunrise;
  String? fajr;
  String? dhuhr;
  String? asr;
  String? sunset;
  String? maghrib;
  String? isha;
  String? midnight;

  TimesModel(
      {required this.asr,
      required this.fajr,
      required this.isha,
      required this.dhuhr,
      required this.imsak,
      required this.midnight,
      required this.maghrib,
      required this.sunrise,
      required this.sunset});

  TimesModel.fromJson(Map<String, dynamic> json) {
    imsak = json['Imsak'];
    sunrise = json['Sunrise'];
    fajr = json['Fajr'];
    dhuhr = json['Dhuhr'];
    asr = json['Asr'];
    sunset = json['Sunset'];
    maghrib = json['Maghrib'];
    isha = json['Isha'];
    midnight = json['Midnight'];
  }
}
