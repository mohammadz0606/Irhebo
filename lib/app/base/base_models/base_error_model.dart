// ignore_for_file: public_member_api_docs, sort_constructors_first

class BaseErrorModel<T> {
  bool? status;
  String? message;
  T? error;

  BaseErrorModel({this.status, this.message, this.error});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'errors': error,
    };
  }

  factory BaseErrorModel.fromJson(
    Map<String, dynamic> map, {
    T Function()? fromJson,
  }) {
    return BaseErrorModel(
        status: map['status'] != null ? map['status'] as bool : null,
        message: map['message'] != null ? map['message'] as String : null,
        error: fromJson != null ? fromJson() : null);
  }
}
