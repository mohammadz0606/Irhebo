import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

sealed class PDFHandler {
  static Future<Response?> downloadAndOpenPDF(
    String url,
    String fileName,
  ) async {
    try {
      String filePath = await _filePath(fileName: fileName, url: url) ?? '';

      /// Download the file
      Dio dio = Dio();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      final data = await dio.download(url, filePath);

      /// Open the file
      if (Platform.isIOS) {
        await OpenFile.open(filePath, type: 'application/pdf');
      } else {
        await OpenFile.open(filePath);
      }
      return data;
    } catch (e) {
      log('Error downloading file: $e');
      return null;
    }
  }

  // static Future<void> shareDownloadedPDF({
  //   required String fileName,
  //   required String url,
  // }) async {
  //   try {
  //     await SharePlus.instance.share(
  //       ShareParams(
  //         text: '${tr('attachedInvoiceShare')} $url',
  //         subject: tr('InvoiceDocument'),
  //       ),
  //     );
  //   } catch (e) {
  //     log('Error sharing file: $e');
  //   }
  // }


  static Future<String?> _filePath({
    required String fileName,
    required String url,
  }) async {
    /// Check for storage permission (Android only)
    // if (Platform.isAndroid) {
    //   // if (await Permission.storage.request().isDenied) {
    //   //   await Permission.storage.request();
    //   // }
    //   var status = await Permission.storage.request();
    //   if (!status.isGranted) {
    //     log('Storage permission denied.');
    //     return null;
    //   }
    // }
    Directory? directory;
    // if (Platform.isAndroid) {
    //   directory = await getExternalStorageDirectory();
    //   if (directory == null || !(await directory.exists())) {
    //     directory = await getApplicationDocumentsDirectory();
    //   }
    // }
    if (Platform.isAndroid) {
      if (Platform.version.contains('10') || Platform.version.contains('11')) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getExternalStorageDirectory();
      }
    }

    /// Get the directory for saving the file

    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = await getExternalStorageDirectory();
      directory ??= Directory('/storage/emulated/0/Download');
    }

    /// Ensure the directory exists
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    /// Ensure unique file name by adding a timestamp
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String baseName = fileName.contains('.')
        ? fileName.substring(0, fileName.lastIndexOf('.'))
        : fileName;
    String extension = fileName.contains('.')
        ? fileName.substring(fileName.lastIndexOf('.') + 1)
        : 'pdf';
    String uniqueFileName = '${baseName}_$timestamp.$extension';
    String filePath = '${directory.path}/$uniqueFileName';

    return filePath;
  }
}


// static Future<void> shareDownloadedPDF({
//   required String fileName,
//   required String url,
// }) async {
//   try {
//     String filePath = await _filePath(fileName: fileName, url: url) ?? '';
//
//     await SharePlus.instance.share(
//       ShareParams(
//         files: [XFile(filePath)],
//         text: tr('attachedInvoiceShare'),
//         subject: tr('InvoiceDocument'),
//       ),
//     );
//   } catch (e) {
//     log('Error sharing file: $e');
//   }
// }