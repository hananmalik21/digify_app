
import 'package:digify_app/core/data/response/status.dart' show Status;

class ApiResponse<T> {
  T? data;
  String? message;
  Status? status;

  ApiResponse({this.data, this.message, this.status});

  ApiResponse.loading({this.message = "Loading..."}) : status = Status.loading;

  ApiResponse.completed(this.data) : status = Status.success;

  ApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
