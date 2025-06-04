import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';

import '../../app/global_imports.dart';

class FilesManagerProvider extends ChangeNotifier {
  bool isLoadingPickFile = false;

  Future<File?>? pickFile({FileType fileType = FileType.any}) async {
    isLoadingPickFile = true;
    final result = await FilePicker.platform.pickFiles(type: fileType);
    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);

      final fileSize = await file.length();
      if (fileSize > 3 * 1024 * 1024) {
        log("File is too large. Max allowed size is 3MB.");
        isLoadingPickFile = false;
        AppSnackBar.openErrorSnackBar(message: 'File is too large'.tr);
        return null;
      }
      isLoadingPickFile = false;
      return file;
    }
    isLoadingPickFile = false;
    return null;
  }

  Future<List<File>> pickMultipleFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.media,
    );

    List<File> validFiles = [];

    if (result != null && result.files.isNotEmpty) {
      for (var picked in result.files) {
        if (picked.path != null) {
          File file = File(picked.path!);

          final fileSize = await file.length();

          if (fileSize <= 3 * 1024 * 1024) {
            validFiles.add(file);
          } else {
            log("File ${picked.name} is too large. Max allowed size is 3MB.");
            AppSnackBar.openErrorSnackBar(
              message: '${picked.name} - ${'File is too large'.tr}',
            );
          }
        }
      }
    }

    return validFiles;
  }

  Future<File> urlToFile(String imageUrl) async {
    final Directory tempDir = await getTemporaryDirectory();

    final String fileName = basename(imageUrl);

    final File file = File('${tempDir.path}/$fileName');

    final response = await Dio().get<List<int>>(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );
    await file.writeAsBytes(response.data!);

    return file;
  }
}
