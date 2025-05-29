
class NewGeneralModel {
  bool? status;
  String? message;
  int? data;

  NewGeneralModel({
    this.status,
    this.message,
    this.data,
  });
  NewGeneralModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = json['data']?.toInt();
  }

}
