class PlanModel {
  bool? status;
  String? message;
  List<PlanModelData?>? data;

  PlanModel({
    this.status,
    this.message,
    this.data,
  });
  PlanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <PlanModelData>[];
      v.forEach((v) {
        arr0.add(PlanModelData.fromJson(v));
      });
      data = arr0;
    }
  }

}

class PlanModelData {
  int? id;
  String? title;
  String? value;

  PlanModelData({
    this.id,
    this.title,
    this.value,
  });
  PlanModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    value = json['value']?.toString();
  }

}


