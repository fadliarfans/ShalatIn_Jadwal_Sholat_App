class City {
  String? id;
  String? lokasi;

  City({this.id, this.lokasi});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lokasi = json['lokasi'];
  }
}
