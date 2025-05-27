// ignore_for_file: public_member_api_docs, sort_constructors_first

class CreateRequestParams {
  final int? serviceId;
  final int? planId;
  CreateRequestParams({
    this.serviceId,
    this.planId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'service_id': serviceId,
      'plan_id': planId,
    };
  }
}
