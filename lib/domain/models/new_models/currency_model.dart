class CurrencyModel {

  bool? status;
  String? message;
  List<CurrencyModelData>? data;

  CurrencyModel({
    this.status,
    this.message,
    this.data,
  });
  CurrencyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <CurrencyModelData>[];
      v.forEach((v) {
        arr0.add(CurrencyModelData.fromJson(v));
      });
      data = arr0;
    }
  }
}


class CurrencyModelData {


  int? id;
  String? code;
  String? symbolEn;
  String? symbolAr;
  String? exchangeRate;

  CurrencyModelData({
    this.id,
    this.code,
    this.symbolEn,
    this.symbolAr,
    this.exchangeRate,
  });
  CurrencyModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    code = json['code']?.toString();
    symbolEn = json['symbol_en']?.toString();
    symbolAr = json['symbol_ar']?.toString();
    exchangeRate = json['exchange_rate']?.toString();
  }
}


