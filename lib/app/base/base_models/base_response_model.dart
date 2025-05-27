// ignore_for_file: public_member_api_docs, sort_constructors_first

class BaseResponseModel<T> {
  bool? status;
  int? statusCode;
  T? data;
  String? message;
  BaseResponseModel({
    this.status,
    this.data,
    this.statusCode,
    this.message,
  });

  factory BaseResponseModel.fromJson(
    Map<String, dynamic> response,
    int statusCode, {
    T Function()? fromJson,
  }) {
    return BaseResponseModel(
        data: fromJson != null ? fromJson() : null,
        message: response['message'],
        status: response['status'],
        statusCode: statusCode);
  }

  factory BaseResponseModel.fromJsonPaginated(
      {required Map<String, dynamic> response,
      required T Function(Map<String, dynamic> json) fromJson}) {
    return BaseResponseModel(
        data: fromJson(response['data']),
        status: response['status'],
        statusCode: response['status_code']);
  }

  BaseResponseEntity toDomain() {
    return BaseResponseEntity(
        data: data, message: message, statusCode: statusCode, success: status);
  }
}

class BaseResponseEntity<E> {
  bool? success;
  int? statusCode;
  E? data;
  String? message;
  BaseResponseEntity({
    this.success,
    this.data,
    this.statusCode,
    this.message,
  });
}
