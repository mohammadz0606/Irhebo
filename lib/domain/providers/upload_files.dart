import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../../app/global_imports.dart';

class UploadFilesProvider extends ChangeNotifier {
  bool isLoadingPickFile = false;

  Future<File?>? pickFile() async {
    isLoadingPickFile = true;
    final result = await FilePicker.platform.pickFiles();
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
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
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
        return validFiles;
      }
    }
    return validFiles;
  }
}
