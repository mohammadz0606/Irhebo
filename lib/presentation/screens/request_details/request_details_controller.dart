import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/models/request_model.dart';
import 'package:irhebo/domain/params/rate_params.dart';
import 'package:irhebo/domain/params/update_request_params.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_request_details_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/review_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/update_request_use_case.dart';
import 'package:irhebo/presentation/screens/request_details/widgets/add_rate_bottom_sheet.dart';
import 'package:irhebo/presentation/screens/request_details/widgets/update_request_dialog.dart';
import 'package:irhebo/presentation/widgets/app_bottom_sheet.dart';
import 'package:irhebo/presentation/widgets/app_dialog.dart';

import '../../../app/network/end_points.dart';
import '../../../app/network/network.dart';
import '../../../app/snack_bar.dart';

class RequestDetailsController extends GetxController {
  final GlobalKey<FormState> reviewKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateRequestKey = GlobalKey<FormState>();

  TextEditingController reviewController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  final RxInt _currentRate = 0.obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isLoadingUpdate = false.obs;
  final RxBool _isLoadingReview = false.obs;
  final Rx<RequestModel> _request = RequestModel().obs;

  int get currentRate => _currentRate.value;

  bool get isLoading => _isLoading.value;

  bool get isLoadingUpdate => _isLoadingUpdate.value;

  bool get isLoadingReview => _isLoadingReview.value;

  RequestModel get request => _request.value;

  set currentRate(value) => _currentRate.value = value;

  set isLoading(value) => _isLoading.value = value;

  set isLoadingUpdate(value) => _isLoadingUpdate.value = value;

  set isLoadingReview(value) => _isLoadingReview.value = value;

  set request(value) => _request.value = value;

  RxList<String?> selectedFilePath = <String?>[].obs;
  List<dio.MultipartFile> atthach = [];
  List<File> attachmentFile = [];
  late List<Uint8List> imageBytes = [];

  RxString selectedStatus = ''.obs;

  List<String> types = [
    "pending".tr,
    "completed".tr,
    "cancelled".tr,
    "confirmed".tr
  ];

  int id = 0;
  String title = "";

  @override
  onInit() async {
    super.onInit();
    receiveParameters();
    if (isClosed) return;
    await getRequestDetails();
  }

  receiveParameters() {
    if (Get.arguments != null) {
      id = Get.arguments["id"] ?? 0;
      title = Get.arguments["title"] ?? "";
    }
  }

  onTapBack() {
    Get.back();
  }

  onTapHistory() {
    if (!isLoading) {
      Get.toNamed(AppRoutes.requestHistory,
          arguments: {"logs": request.logs ?? []});
    }
  }

  submit() {
    if (reviewKey.currentState!.validate()) {
      review();
    }
  }

  review() async {
    isLoadingReview = true;
    ReviewUseCase reviewUseCase = sl();
    final result = await reviewUseCase(RateParams(
        comment: reviewController.text,
        rating: currentRate,
        serviceId: request.service?.id));
    result!.fold((l) {
      isLoadingReview = false;
    }, (r) {
      request.isReviewed = true;
      _request.refresh();
      Get.back();
      isLoadingReview = false;
    });
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

  clearData() {
    commentController.clear();
    selectedStatus = ''.obs;
    clearFiles();
  }

  onChangeStatus(String? status) {
    if (status != null) {
      selectedStatus.value = status;
    }
  }

  clearFiles() {
    selectedFilePath.clear();
    atthach.clear();
    attachmentFile.clear();
    imageBytes.clear();
  }

  onUpadteRequest() {
    if (updateRequestKey.currentState!.validate()) {
      updateRequest();
    }
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

  void openReviewBottomSheet() {
    if (Get.context != null && Get.context!.mounted) {
      Get.bottomSheet(
        AppBottomSheet(title: "Rate", child: AddRateBottomSheet()),
        backgroundColor: Get.find<AppController>().darkMode
            ? AppDarkColors.darkScaffoldColor
            : AppLightColors.pureWhite,
        barrierColor: Get.find<AppController>().darkMode
            ? AppDarkColors.darkContainer.withOpacity(0.3)
            : AppLightColors.shadow.withOpacity(0.3),
        elevation: 0,
        isScrollControlled: true,
      );
    }
  }

  getRequestDetails() async {
    //RequestModel
    isLoading = true;
    GetRequestDetailsUseCase getRequestDetailsUseCase = sl();
    final result = await getRequestDetailsUseCase(id);
    result!.fold((l) {
      isLoading = false;
    }, (r) {
      request = r.data;
      _request.refresh();
      isLoading = false;
    });

    // try {
    //   final response = await Network().get(
    //     url: '${AppEndpoints.requestDetails}$id',
    //   );
    //
    //   String errorMessage = await Network().handelError(response: response);
    //
    //   if (errorMessage.isNotEmpty) {
    //     isLoading = false;
    //     AppSnackBar.openErrorSnackBar(
    //       message: errorMessage,
    //     );
    //     return;
    //   }
    //   RequestModel requestModel = RequestModel.fromJson(response.data);
    //   request = requestModel;
    //   _request.refresh();
    //   isLoading = false;
    // } catch (error) {
    //   if (error is dio.DioException) {
    //     AppSnackBar.openErrorSnackBar(
    //       message: Network().handelDioException(error),
    //     );
    //   } else {
    //     AppSnackBar.openErrorSnackBar(
    //       message: error.toString(),
    //     );
    //   }
    //
    //   isLoading = false;
    // }
  }

  updateRequest() async {
    isLoadingUpdate = true;
    UpdateRequestUseCase updateRequestUseCase = sl();
    final result = await updateRequestUseCase(UpdateRequestParams(
        action: commentController.text,
        status: selectedStatus.value,
        requestId: request.id,
        attachments: atthach));
    result!.fold((l) {
      isLoadingUpdate = false;
    }, (r) {
      clearData();
      isLoadingUpdate = false;
      Get.back();
      getRequestDetails();
    });
  }

  onRate(int i) {
    if (currentRate == i) {
      currentRate--;
    } else {
      currentRate = i;
      // log(currentRate.toString());
      // _currentRate.refresh();
    }
  }

  openUpdateRequestDialog() {
    Get.dialog(
      barrierColor: Get.find<AppController>().darkMode
          ? AppDarkColors.darkContainer.withOpacity(0.3)
          : AppLightColors.shadow.withOpacity(0.3),
      AppDialog(
        child: UpdateRequestDialog(),
      ),
    );
  }
}
