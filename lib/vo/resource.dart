import 'status.dart';

class Resource<Data> {
  Status? status;
  Data? data;
  String? message;

  Resource({this.message, this.data, this.status});

  Resource<Data> success(Data value, {required String message}) {
    return Resource<Data>(status: Status.SUCCES, data: value, message: message);
  }

  Resource<Data> error(String error) {
    return Resource<Data>(status: Status.ERROR, data: null, message: error);
  }
}
