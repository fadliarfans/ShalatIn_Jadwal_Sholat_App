import 'package:jadwal_sholat_app/vo/status.dart';

class Resource<Data> {
  Status? status;
  Data? data;
  String? message;

  Resource({this.message, this.data, this.status});

  Resource<Data> success(Data value) {
    return Resource<Data>(
        status: Status.SUCCES, data: value, message: "SUCCES");
  }

  Resource<Data> error(String error) {
    return Resource<Data>(status: Status.ERROR, data: null, message: error);
  }
}
