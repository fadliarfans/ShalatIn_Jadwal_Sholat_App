class Jadwalresponse {
  bool? status;
  DataJadwal? data;

  Jadwalresponse({this.status, this.data});

  Jadwalresponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataJadwal.fromJson(json['data']) : null;
  }
}

class DataJadwal {
  String? id;
  String? lokasi;
  String? daerah;
  Koordinat? koordinat;
  List<Jadwal>? jadwal;

  DataJadwal({this.id, this.lokasi, this.daerah, this.koordinat, this.jadwal});

  DataJadwal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lokasi = json['lokasi'];
    daerah = json['daerah'];
    koordinat = json['koordinat'] != null
        ? Koordinat.fromJson(json['koordinat'])
        : null;
    if (json['jadwal'] != null) {
      jadwal = <Jadwal>[];
      json['jadwal'].forEach((v) {
        jadwal!.add(Jadwal.fromJson(v));
      });
    }
  }
}

class Koordinat {
  double? lat;
  double? lon;
  String? lintang;
  String? bujur;

  Koordinat({this.lat, this.lon, this.lintang, this.bujur});

  Koordinat.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    lintang = json['lintang'];
    bujur = json['bujur'];
  }
}

class Jadwal {
  String? tanggal;
  String? imsak;
  String? subuh;
  String? terbit;
  String? dhuha;
  String? dzuhur;
  String? ashar;
  String? maghrib;
  String? isya;
  String? date;

  Jadwal(
      {this.tanggal,
      this.imsak,
      this.subuh,
      this.terbit,
      this.dhuha,
      this.dzuhur,
      this.ashar,
      this.maghrib,
      this.isya,
      this.date});

  Jadwal.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    imsak = json['imsak'];
    subuh = json['subuh'];
    terbit = json['terbit'];
    dhuha = json['dhuha'];
    dzuhur = json['dzuhur'];
    ashar = json['ashar'];
    maghrib = json['maghrib'];
    isya = json['isya'];
    date = json['date'];
  }
}
