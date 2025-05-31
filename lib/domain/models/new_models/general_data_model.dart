
final class NewGeneralDataModel {
  bool? status;
  String? message;
  int? data;

  NewGeneralDataModel({
    this.status,
    this.message,
    this.data,
  });
  NewGeneralDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = json['data']?.toInt();
  }

}
