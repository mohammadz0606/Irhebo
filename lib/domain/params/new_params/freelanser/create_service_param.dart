import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../app/injection.dart';
import '../../../../app/storage/app_prefs.dart';
import '../../../../app/storage/app_prefs_keys.dart';

final class CreateServiceParam {
  final int supCategoryId;
  final String title;
  final String description;
  final File? cover;
  final List<File> media;
  final List<int> planId;
  final List<double> price;
  final List<int> deliveryDays;
  final List<bool> sourceFile;
  final List<int> revision;
  final List<String> tags;
  final String currency;

  const CreateServiceParam({
    required this.supCategoryId,
    required this.title,
    required this.description,
    required this.cover,
    required this.media,
    required this.planId,
    required this.price,
    required this.deliveryDays,
    required this.sourceFile,
    required this.revision,
    required this.tags,
    required this.currency,
  });

  Future<FormData> toJson() async {
    final formDataFields = <MapEntry<String, dynamic>>[];

    if(cover != null) {
      final coverFileName = cover!.path.split('/').last;
      formDataFields.add(MapEntry(
        "cover",
        await MultipartFile.fromFile(cover!.path, filename: coverFileName),
      ));
    }


    List<MultipartFile> multiFiles = [];
    for (var file in media) {
      final fileName = file.path.split('/').last;
      multiFiles.add(
        await MultipartFile.fromFile(file.path, filename: fileName),
      );
    }

    formDataFields.add(MapEntry("sub_category_id", supCategoryId));
    formDataFields.add(MapEntry("title", title.trim()));
    formDataFields.add(MapEntry("description", description.trim()));


    formDataFields.add(MapEntry("currency", currency));

    for (int i = 0; i < multiFiles.length; i++) {
      formDataFields.add(MapEntry("media[$i]", multiFiles[i]));
    }

    for (int i = 0; i < tags.length; i++) {
      formDataFields.add(MapEntry("tags[$i]", tags[i]));
    }
    for (int i = 0; i < planId.length; i++) {
      formDataFields.add(MapEntry("plans[$i][plan_id]", planId[i]));

      ///---
      formDataFields.add(MapEntry("plans[$i][features][0][title]", 'Price'));
      formDataFields.add(MapEntry("plans[$i][features][0][type]", 'price'));
      formDataFields.add(MapEntry("plans[$i][features][0][value]", price[i].toString().replaceAll(',', '.')));
      ///----
      formDataFields
          .add(MapEntry("plans[$i][features][1][title]", 'Delivery Days'));
      formDataFields
          .add(MapEntry("plans[$i][features][1][type]", 'delivery_days'));
      formDataFields
          .add(MapEntry("plans[$i][features][1][value]", deliveryDays[i]));

      ///----

      formDataFields
          .add(MapEntry("plans[$i][features][2][title]", 'Source Files'));
      formDataFields
          .add(MapEntry("plans[$i][features][2][type]", 'source_files'));
      formDataFields
          .add(MapEntry("plans[$i][features][2][value]", sourceFile[i]));

      ///----

      formDataFields
          .add(MapEntry("plans[$i][features][3][title]", 'Revisions'));
      formDataFields.add(MapEntry("plans[$i][features][3][type]", 'revisions'));
      formDataFields
          .add(MapEntry("plans[$i][features][3][value]", revision[i]));
    }

    return FormData.fromMap(Map.fromEntries(formDataFields));
  }
}
