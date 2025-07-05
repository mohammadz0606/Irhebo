import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

final class CreatePortfolioParam {
  final String title;
  final QuillController description;
  final File? cover;
  final List<int> services;
  final List<File>? media;

  const CreatePortfolioParam({
    required this.title,
    required this.description,
    this.cover,
    required this.services,
    this.media,
  });

  Future<FormData> toJson() async {
    final formData = FormData();

    if (media != null && media!.isNotEmpty) {
      for (var file in media!) {
        final fileName = file.path.split('/').last;
        final multipart =
            await MultipartFile.fromFile(file.path, filename: fileName);
        formData.files.add(MapEntry("media[]", multipart));
      }
    }

    formData.fields.add(MapEntry("title", title.trim()));

    final delta = description.document.toDelta();
    final deltaJson = delta.toJson();

    final converter = QuillDeltaToHtmlConverter(deltaJson);
    final html = converter.convert();

    formData.fields.add(MapEntry("description", html));

    if (cover != null) {
      final coverFileName = cover!.path.split('/').last;
      final coverMultipart =
          await MultipartFile.fromFile(cover!.path, filename: coverFileName);
      formData.files.add(MapEntry("cover", coverMultipart));
    }

    final uniqueServiceIds = services.toSet();
    for (var id in uniqueServiceIds) {
      formData.fields.add(MapEntry("service_ids[]", id.toString()));
    }

    return formData;
  }
}
