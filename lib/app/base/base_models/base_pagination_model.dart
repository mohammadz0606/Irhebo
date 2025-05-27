// ignore_for_file: public_member_api_docs, sort_constructors_first
class BasePaginationModel<T> {
  List<T>? data;
  PagintaionParamsModel? paginate;
  BasePaginationModel({
    this.data,
    this.paginate,
  });

  factory BasePaginationModel.fromJson({
    required Map<String, dynamic> response,
    required T Function(Map<String, dynamic> json) fromJsonT,
  }) {
    return BasePaginationModel<T>(
      data:
          (response['data'] as List<dynamic>).map((e) => fromJsonT(e)).toList(),
      paginate: PagintaionParamsModel.fromJson(response['paginate']),
    );
  }

  BasePaginationEntity toDomain() {
    return BasePaginationEntity(
        data: data, paginate: paginate != null ? paginate!.toDomain() : null);
  }
}

class PagintaionParamsModel {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? pageFrom;
  int? pageTo;
  PagintaionParamsModel({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.pageFrom,
    this.pageTo,
  });

  factory PagintaionParamsModel.fromJson(
    Map<String, dynamic> response,
  ) {
    return PagintaionParamsModel(
      total: response['total'],
      perPage: response['perPage'],
      currentPage: response['currentPage'],
      lastPage: response['lastPage'],
      pageFrom: response['pageFrom'],
      pageTo: response['pageTo'],
    );
  }

  PagintaionParamsEntity toDomain() {
    return PagintaionParamsEntity(
        currentPage: currentPage,
        lastPage: lastPage,
        pageFrom: pageFrom,
        pageTo: pageTo,
        perPage: perPage,
        total: total);
  }
}

class BasePaginationEntity<E> {
  List<E>? data;
  PagintaionParamsEntity? paginate;
  BasePaginationEntity({
    this.data,
    this.paginate,
  });
}

class PagintaionParamsEntity {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? pageFrom;
  int? pageTo;

  PagintaionParamsEntity({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.pageFrom,
    this.pageTo,
  });
}
