class JadwalResponseSecondModel {
  JadwalResponseSecondModel({this.code, this.status, this.results});

  JadwalResponseSecondModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    results =
        json['results'] != null ? Results.fromJson(json['results']) : null;
  }

  int? code;
  Results? results;
  String? status;
}

class Results {
  Results({this.datetime, this.location, this.settings});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['datetime'] != null) {
      datetime = <Datetime>[];
      json['datetime'].forEach((v) {
        datetime!.add(Datetime.fromJson(v));
      });
    }
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    settings =
        json['settings'] != null ? Settings.fromJson(json['settings']) : null;
  }

  List<Datetime>? datetime;
  Location? location;
  Settings? settings;
}

class Datetime {
  Datetime({this.times, this.date});

  Datetime.fromJson(Map<String, dynamic> json) {
    times = json['times'] != null ? Times.fromJson(json['times']) : null;
    date = json['date'] != null ? Date.fromJson(json['date']) : null;
  }

  Date? date;
  Times? times;
}

class Times {
  Times(
      {this.imsak,
      this.sunrise,
      this.fajr,
      this.dhuhr,
      this.asr,
      this.sunset,
      this.maghrib,
      this.isha,
      this.midnight});

  Times.fromJson(Map<String, dynamic> json) {
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

  String? asr;
  String? dhuhr;
  String? fajr;
  String? imsak;
  String? isha;
  String? maghrib;
  String? midnight;
  String? sunrise;
  String? sunset;
}

class Date {
  Date({this.timestamp, this.gregorian, this.hijri});

  Date.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    gregorian = json['gregorian'];
    hijri = json['hijri'];
  }

  String? gregorian;
  String? hijri;
  int? timestamp;
}

class Location {
  Location(
      {this.latitude,
      this.longitude,
      this.elevation,
      this.city,
      this.country,
      this.countryCode,
      this.timezone,
      this.localOffset});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    elevation = json['elevation'];
    city = json['city'];
    country = json['country'];
    countryCode = json['country_code'];
    timezone = json['timezone'];
    localOffset = json['local_offset'];
  }

  String? city;
  String? country;
  String? countryCode;
  double? elevation;
  double? latitude;
  double? localOffset;
  double? longitude;
  String? timezone;
}

class Settings {
  Settings(
      {this.timeformat,
      this.school,
      this.juristic,
      this.highlat,
      this.fajrAngle,
      this.ishaAngle});

  Settings.fromJson(Map<String, dynamic> json) {
    timeformat = json['timeformat'];
    school = json['school'];
    juristic = json['juristic'];
    highlat = json['highlat'];
    fajrAngle = json['fajr_angle'];
    ishaAngle = json['isha_angle'];
  }

  double? fajrAngle;
  String? highlat;
  double? ishaAngle;
  String? juristic;
  String? school;
  String? timeformat;
}
