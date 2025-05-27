class PaginationParams {
  final int? perPage;
  final int? page;
  final int? id;
  final String? tag;
  final String? query;

  PaginationParams({
    this.id,
    this.tag,
    this.perPage,
    this.page,
    this.query,
  });

  PaginationParams copyWith({
    int? perPage,
    int? page,
  }) =>
      PaginationParams(
        perPage: perPage ?? this.perPage,
        page: page ?? this.page,
      );

  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      PaginationParams(
        perPage: json["per_page"],
        page: json["page"],
      );

  Map<String, dynamic> toJson() => {
        if (perPage != null) "per_page": perPage,
        if (page != null) "page": page,
        if (query != null) "query": query,
      };
}
