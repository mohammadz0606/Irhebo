// ignore_for_file: invalid_use_of_protected_member
import 'dart:developer';

import 'package:dio/dio.dart' as dio;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_functions.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/models/ticket_model.dart';
import 'package:irhebo/domain/params/add_ticket_response_params.dart';
import 'package:irhebo/domain/usecases/setting_usecase/add_ticket_response_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/close_ticket_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/get_ticket_details_use_case.dart';

class TicketDetailsController extends GetxController {
  ScrollController scrollController = ScrollController();
  AnimationController? galleryAnimationController;

  Rx<TextEditingController> chatMessage = TextEditingController().obs;
  int id = 0;
  List<dio.MultipartFile> atthach = [];

  var selectedFilePath = <String?>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isLoadingAdd = false.obs;
  final RxBool _isLoadingClose = false.obs;
  var attachAnimated = false.obs;

  bool get isLoading => _isLoading.value;
  bool get isLoadingAdd => _isLoadingAdd.value;
  bool get isLoadingClose => _isLoadingClose.value;

  set isLoading(value) => _isLoading.value = value;
  set isLoadingAdd(value) => _isLoadingAdd.value = value;
  set isLoadingClose(value) => _isLoadingClose.value = value;

  final RxList<TicketModel> _tickets = <TicketModel>[].obs;
  RxMap<String, List<TicketModel>> groupedTickets =
      <String, List<TicketModel>>{}.obs;
  List<TicketModel> get tickets => _tickets;
  set tickets(List<TicketModel> value) {
    _tickets.value = value;
    groupTickets();
  }

  onTapBack() {
    Get.back();
  }

  void groupTickets() {
    Map<String, List<TicketModel>> grouped = {};
    _tickets.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    for (var log in _tickets) {
      String formattedDate = formatDate(DateTime.parse(log.createdAt!));
      grouped.putIfAbsent(formattedDate, () => []).add(log);
    }
    groupedTickets.value = grouped; // Assign to reactive map
  }

  TicketModel mainTicket = TicketModel();

  @override
  onInit() async {
    super.onInit();
    receiveParameters();
    await getTickets();
  }

  onTapSend() async {
    await addTicketRespose();
    // chatMessage.value.clear();
    selectedFilePath.value = [];
    chatMessage.value.clear();
    reverse();
  }

  reverse() {
    Future.delayed(100.ms, () {
      galleryAnimationController?.reverse();
    });
  }

  toggleAttachAnimation() {
    FocusScope.of(Get.context!).unfocus();
    if (attachAnimated.value) {
      Future.delayed(100.ms, () {
        galleryAnimationController?.reverse();
      });
    } else {
      galleryAnimationController?.forward();
      Future.delayed(50.ms, () {});
    }
    attachAnimated.value = !attachAnimated.value;
  }

  onStartTyping() {
    reverse();
    chatMessage.refresh();
  }

  dismissFiles() {
    selectedFilePath.value.clear();
    selectedFilePath.refresh();
    atthach.clear();
  }

  pickChatFile(FileType fileTypee) async {
    // chatMessage.value.clear();
    toggleAttachAnimation();
    var result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: fileTypee);
    if (result != null) {
      selectedFilePath.addAll(result.paths);
      for (var path in result.paths) {
        if (path != null && path.isNotEmpty) {
          final multipartFile = await dio.MultipartFile.fromFile(
            path,
            filename: path.split('/').last,
          );
          atthach.add(multipartFile);
        }
      }
    }
  }

  scrollToEnd() async {
    reverse();
    await Future.delayed(Duration(milliseconds: 500), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  getTickets() async {
    isLoading = true;
    GetTicketDetailsUseCase getTicketDetailsUseCase = sl();
    final result = await getTicketDetailsUseCase(id);
    result!.fold((l) {
      isLoading = false;
    }, (r) {
      tickets = r.data ?? [];
      _tickets.refresh();
      groupTickets();
      // scrollToEnd();
      isLoading = false;
    });
  }

  closeTicket() async {
    isLoadingClose = true;
    CloseTicketUseCase closeTicketUseCase = sl();
    final result = await closeTicketUseCase(id);
    result!.fold((l) {
      isLoadingClose = false;
    }, (r) {
      mainTicket.status = "Closed";
      isLoadingClose = false;
    });
  }

  addTicketRespose() async {
    isLoadingAdd = true;
    List<dio.MultipartFile> clonedAttachments =
        atthach.map((file) => file.clone()).toList();
    AddTicketResponseUseCase addTicketResponseUseCase = sl();
    final result = await addTicketResponseUseCase(AddTicketResponseParams(
        message: chatMessage.value.text,
        ticketId: id,
        attachment: clonedAttachments));
    result!.fold((l) {
      isLoadingAdd = false;
    }, (r) {
      isLoadingAdd = false;
      log(tickets.length.toString() + "asas");
      tickets.add(r.data!);
      log(tickets.length.toString() + "qwwq ");
      groupTickets();
      _tickets.refresh();
    });
  }

  onTapOutside() {}

  onTapAttachment(int ticketIndex, int attachmentIndex) async {
    await Get.toNamed(AppRoutes.gallery, arguments: {
      "index": attachmentIndex,
      "media_list": tickets[ticketIndex].attachments,
    });
  }

  receiveParameters() {
    if (Get.arguments != null) {
      id = Get.arguments["id"] ?? 0;
      mainTicket = Get.arguments["ticket"];
    }
  }
}
