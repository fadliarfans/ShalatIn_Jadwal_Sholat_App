class JadwalModel {
  bool? status;
  DataRegion? data;

  JadwalModel({this.status, this.data});

  JadwalModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataRegion.fromJson(json['data']) : null;
  }
}

class DataRegion {
  String? date;
  String? region;
  List<DataTimes>? data;

  DataRegion({this.date, this.region, this.data});

  DataRegion.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    region = json['region'];
    if (json['data'] != null) {
      data = <DataTimes>[];
      json['data'].forEach((v) {
        data!.add(DataTimes.fromJson(v));
      });
    }
  }
}

class DataTimes {
  String? name;
  String? time;

  DataTimes({this.name, this.time});

  DataTimes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    time = json['time'];
  }
}
