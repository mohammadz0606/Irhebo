import 'dart:io';

import 'package:dio/dio.dart';

final class CompleteProfileParam {
  final File avatar;
  final String bio;
  final List<int> categoryIds;
  final List<File> files;
  final List<String> descriptions;

  const CompleteProfileParam({
    required this.avatar,
    required this.bio,
    required this.categoryIds,
    required this.files,
    required this.descriptions,
  });

  Future<Map<String, dynamic>> toJson() async {
    List<MultipartFile> multipartFiles = [];

    for (var file in files) {
      final fileName = file.path.split('/').last;
      multipartFiles
          .add(await MultipartFile.fromFile(file.path, filename: fileName));
    }

    final avatarFileName = avatar.path.split('/').last;

    return {
      'avatar':
          await MultipartFile.fromFile(avatar.path, filename: avatarFileName),
      'bio': bio,
      "category_ids": categoryIds,
      "files": multipartFiles,
      "descriptions": descriptions,
    };
  }
}
