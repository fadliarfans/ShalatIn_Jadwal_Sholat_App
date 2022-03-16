class LocationModel {
  double? latitude;
  double? longitude;
  double? elevation;
  String? country;
  String? countryCode;
  String? timezone;
  double? localOffset;

  LocationModel(
      {required this.country,
      required this.countryCode,
      required this.elevation,
      required this.latitude,
      required this.localOffset,
      required this.longitude,
      required this.timezone});

  LocationModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    elevation = json['elevation'];
    country = json['country'];
    countryCode = json['country_code'];
    timezone = json['timezone'];
    localOffset = json['local_offset'];
  }
}
