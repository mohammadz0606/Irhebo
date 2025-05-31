final class NewGeneralModel {
  bool? status;
  String? message;

  NewGeneralModel({
    this.status,
    this.message,
  });

  NewGeneralModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
  }
}
