import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/models/request_model.dart';
import 'package:irhebo/domain/params/create_ticket_params.dart';
import 'package:irhebo/domain/usecases/setting_usecase/create_ticket_use_case.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/requests/requests_controller.dart';
import 'package:irhebo/presentation/screens/create_ticket/widgets/ticket_submitted_dialog.dart';
import 'package:irhebo/presentation/widgets/app_dialog.dart';

class CreateTicketController extends GetxController {
  final requestsControllerr = Get.find<RequestsController>();

  final GlobalKey<FormState> createTicketKey = GlobalKey<FormState>();

  final RxBool _isLoading = false.obs;
  TextEditingController subject = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController issue = TextEditingController();
  TextEditingController phone = TextEditingController();
  RxList<String?> selectedFilePath = <String?>[].obs;
  List<dio.MultipartFile> atthach = [];
  List<File> attachmentFile = [];
  late List<Uint8List> imageBytes = [];

  // ignore: invalid_use_of_protected_member
  final formData = dio.FormData();

  Rx<RequestModel> _request = RequestModel().obs;

  bool get isLoading => _isLoading.value;
  RequestModel get request => _request.value;

  set isLoading(value) => _isLoading.value = value;
  set request(value) => _request.value = value;

  @override
  onInit() async {
    super.onInit();
  }

  openTicketSubmittedDialog() {
    Get.dialog(
      barrierColor: Get.find<AppController>().darkMode
          ? AppDarkColors.darkContainer.withOpacity(0.3)
          : AppLightColors.shadow.withOpacity(0.3),
      AppDialog(
        child: TicketSubmittedDialog(),
      ),
    );
  }

  onSelectRequest(RequestModel? value) {
    request = value;
    _request.refresh();
  }

  addAttachments() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result != null) {
      selectedFilePath.addAll(result.paths);
      for (var path in result.paths) {
        if (path != null && path.isNotEmpty) {
          final multipartFile = await dio.MultipartFile.fromFile(
            path,
            filename: path.split('/').last,
          );
          atthach.add(multipartFile);
          final file = File(path);
          attachmentFile.add(file);
          final bytes = await file.readAsBytes();
          imageBytes.add(bytes);
        }
      }
    }
  }

  onSubmit() async {
    if (createTicketKey.currentState!.validate()) {
      await createTicket();
    }
  }

  createTicket() async {
    isLoading = true;
    CreateTicketUseCase createTicketUseCase = sl();
    final result = await createTicketUseCase(CreateTicketParams(
        message: issue.text,
        subject: subject.text,
        requestId: request.id,
        attachment: atthach));
    result!.fold((l) {
      isLoading = false;
    }, (r) {
      clearData();
      openTicketSubmittedDialog();
      isLoading = false;
    });
  }

  clearData() {
    request = RequestModel();
    _request.refresh();
    subject.text = " ";
    email.text = " ";
    issue.text = " ";
    phone.text = " ";
    clearFiles();
  }

  clearFiles() {
    selectedFilePath.clear();
    atthach.clear();
    attachmentFile.clear();
    imageBytes.clear();
  }

  onOpenFile(int index) async {
    await Get.toNamed(AppRoutes.gallery,
        arguments: {"files_list": imageBytes, "index": index});
  }

  dismissFile(int index) async {
    selectedFilePath.removeAt(index);
    attachmentFile.removeAt(index);
    imageBytes.removeAt(index);
  }
}
