import 'dart:io';

import 'package:irhebo/app/enums.dart';

import 'package:dio/dio.dart';

final class SendMessageParam {
  final int chatId;
  final String? message;
  final File? attachmentFile;
  final MessageType messageType;

  SendMessageParam({
    required this.chatId,
    required this.message,
    required this.attachmentFile,
    required this.messageType,
  });

  Future<Map<String, dynamic>> toJson() async {
    Map<String, dynamic> data = {};
    data['chat_id'] = chatId;
    if (attachmentFile != null) {
      final attachmentFileName = attachmentFile!.path.split('/').last;

      data['attachment_file'] = await MultipartFile.fromFile(
        attachmentFile!.path,
        filename: attachmentFileName,
      );
      data['attachment_type'] = messageType.name;
    }
    data['message'] = message?.trim() ?? '';
    // if (message != null) {
    //
    // }
    return data;

    // final formData = FormData();
    // formData.fields.add(MapEntry("chat_id", chatId.toString()));
    // if (messageType != MessageType.text) {
    //   formData.fields.add(MapEntry("attachment_type", messageType.name));
    // }
    //
    // if (message != null) {
    //   formData.fields.add(MapEntry("message", message!.trim()));
    // }
    //
    // if (attachmentFile != null) {
    //   final attachmentFileName = attachmentFile!.path.split('/').last;
    //   formData.files.add(MapEntry(
    //     "attachment_file",
    //     await MultipartFile.fromFile(attachmentFile!.path,
    //         filename: attachmentFileName),
    //   ));
    // }
    //
    // return formData;
  }
}
