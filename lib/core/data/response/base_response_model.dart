class BaseApiResponseModel {
  bool? success;
  String? message;
  dynamic data;

  BaseApiResponseModel({this.success, this.message,this.data});

  BaseApiResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = data;
    return data;
  }
}
