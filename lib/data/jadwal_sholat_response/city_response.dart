class Cities {
  bool? status;
  List<City>? data;

  Cities({this.status, this.data});

  Cities.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <City>[];
      json['data'].forEach((v) {
        data!.add(City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  String? cityId;
  String? cityName;

  City({this.cityId, this.cityName});

  City.fromJson(Map<String, dynamic> json) {
    cityId = json['cityId'];
    cityName = json['cityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cityId'] = cityId;
    data['cityName'] = cityName;
    return data;
  }
}
