import '../../app/injection.dart';
import '../../app/storage/app_prefs.dart';
import '../../app/storage/app_prefs_keys.dart' show AppPrefsKeys;

class CreateQuotationParams {
  String? title;
  String? description;
  double? price;
  int? deliveryDay;
  int? revisions;
  bool? sourceFile;
  int? subCategoryId;

  CreateQuotationParams({
    this.title,
    this.description,
    this.price,
    this.deliveryDay,
    this.revisions,
    this.sourceFile,
    this.subCategoryId,
  });

  CreateQuotationParams.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    price = json['price'];
    deliveryDay = json['delivery_day'];
    revisions = json['revisions'];
    sourceFile = json['source_file'];
    subCategoryId = json['sub_category_id'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (revisions != null) 'revisions': revisions,
      if (deliveryDay != null) 'delivery_day': deliveryDay,
      if (sourceFile != null) 'source_file': sourceFile,
      'currency' : AppPreferences(sl()).getString(key: AppPrefsKeys.CURRENCY) ?? 'USD',
      'sub_category_id' : subCategoryId,
    };
  }
}
