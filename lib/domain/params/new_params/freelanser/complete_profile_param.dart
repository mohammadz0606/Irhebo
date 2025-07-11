import 'dart:io';

import 'package:dio/dio.dart';

final class CompleteProfileParam {
  final File? avatar;
  final String bio;
  final List<int> categoryIds;
  final List<File>? files;
  final List<String> descriptions;

  const CompleteProfileParam({
    required this.avatar,
    required this.bio,
    required this.categoryIds,
    required this.files,
    required this.descriptions,
  });

  /*
 Future<FormData> toJson() async {
    final avatarFileName = cover.path.split('/').last;

    List<MultipartFile> multipartMedia = [];
    for (var file in media) {
      final fileName = file.path.split('/').last;
      multipartMedia.add(
        await MultipartFile.fromFile(file.path, filename: fileName),
      );
    }


    final formDataFields = <MapEntry<String, dynamic>>[];

    formDataFields.add(MapEntry("title", title.trim()));
    formDataFields.add(MapEntry("description", description.trim()));
    formDataFields.add(MapEntry(
      "cover",
      await MultipartFile.fromFile(cover.path, filename: avatarFileName),
    ));

    for (var file in multipartMedia) {
      formDataFields.add(MapEntry("media[]", file));
    }

    for (var id in services) {
      formDataFields.add(MapEntry("service_ids[]", id.toString()));
    }

    return FormData.fromMap(Map.fromEntries(formDataFields));
  }
   */

  Future<FormData> toJson() async {
    final formData = FormData();

    if (files != null && files!.isNotEmpty) {
      List<MultipartFile> multiFiles = [];
      for (var file in files!) {
        final fileName = file.path.split('/').last;
        multiFiles.add(
          await MultipartFile.fromFile(file.path, filename: fileName),
        );
      }
      for (var file in multiFiles) {
        formData.files.add(MapEntry("file[]", file));
      }
    }

    formData.fields.add(MapEntry("bio", bio.trim()));

    if (avatar != null) {
      final avatarFileName = avatar!.path.split('/').last;
      formData.files.add(MapEntry(
        "avatar",
        await MultipartFile.fromFile(avatar!.path, filename: avatarFileName),
      ));
    }

    for (var id in categoryIds) {
      formData.fields.add(MapEntry("category_ids[]", id.toString()));
    }

    if (descriptions.isEmpty) {
      for (var description in descriptions) {
        if (description.trim().isNotEmpty) {
          formData.fields.add(MapEntry("description[]", description.trim()));
        }
      }
    }

    return formData;
  }
}
