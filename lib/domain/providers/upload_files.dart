import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../../app/global_imports.dart';

class UploadFilesProvider extends ChangeNotifier {
  //String fileName = file.path.split('/').last;
  // "file": await MultipartFile.fromFile(
  // file.path,
  // filename: fileName,
  // ),

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
}
