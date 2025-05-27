// ignore_for_file: public_member_api_docs, sort_constructors_first

class RateParams {
  final int? serviceId;
  final String? comment;
  final int? rating;
  RateParams({
    this.serviceId,
    this.comment,
    this.rating,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (serviceId != null) 'service_id': serviceId,
      if (comment != null) 'comment': comment,
      if (rating != null) 'rating': rating,
    };
  }
}
