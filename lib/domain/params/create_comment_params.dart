class CreateCommentParams {
  String? quotationId;
  String? comment;

  CreateCommentParams({
    this.quotationId,
    this.comment,
  });

  CreateCommentParams.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    quotationId = json['quotationId'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (comment != null) 'comment': comment,
      if (quotationId != null) 'quotation_id': quotationId,
    };
  }
}
