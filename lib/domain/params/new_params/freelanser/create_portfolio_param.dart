import 'dart:io';

import 'package:dio/dio.dart';

final class CreatePortfolioParam {
  final String title;
  final String description;
  final File cover;
  final List<int> services;
  final List<File> media;

  const CreatePortfolioParam({
    required this.title,
    required this.description,
    required this.cover,
    required this.services,
    required this.media,
  });

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
}
