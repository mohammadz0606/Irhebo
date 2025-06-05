import 'dart:io';

import 'package:dio/dio.dart';
import 'package:irhebo/app/global_imports.dart' hide MultipartFile, FormData;
import 'package:irhebo/domain/models/new_models/general_model.dart';

import '../../../app/network/network.dart';
import '../../../app/router/routes.dart';
import '../../../presentation/screens/profile/profile_controller.dart';
import '../../models/new_models/complete_profile.dart';
import '../../params/new_params/freelanser/complete_profile_param.dart';

class CompleteProfileProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadingVerifyAccount = false;

  completeProfile({required CompleteProfileParam data}) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await Network()
          .post(url: AppEndpoints.completeProfile, data: await data.toJson());

      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoading = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }

      FreelancerServiceModel model =
          FreelancerServiceModel.fromJson(response.data);

      AppPreferences prefs = sl();
      prefs.setString(
        key: AppPrefsKeys.USER_ROLE,
        value: model.data?.role ?? '',
      );
      isLoading = false;
      notifyListeners();
      Get.offAllNamed(AppRoutes.bottomNavBar);
    } catch (error) {
      if (error is DioException) {
        AppSnackBar.openErrorSnackBar(
          message: Network().handelDioException(error),
        );
      } else {
        AppSnackBar.openErrorSnackBar(
          message: error.toString(),
        );
      }

      isLoading = false;
      notifyListeners();
    }
  }

  verifyAccount({required File file}) async {
    try {
      isLoadingVerifyAccount = true;
      notifyListeners();

      final fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final response = await Network().post(
        url: AppEndpoints.verifyAccount,
        isUploadFile: true,
        data: formData,
      );
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingVerifyAccount = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }

      NewGeneralModel model = NewGeneralModel.fromJson(response.data);
      if (model.status == true) {
        Get.find<ProfileController>().getFreelancerProfile();
        Get.back();
        isLoadingVerifyAccount = false;
        notifyListeners();
        AppSnackBar.openSuccessSnackBar(
          message: 'Account verified successfully'.tr,
        );
      }
    } catch (error) {
      if (error is DioException) {
        AppSnackBar.openErrorSnackBar(
          message: Network().handelDioException(error),
        );
      } else {
        AppSnackBar.openErrorSnackBar(
          message: error.toString(),
        );
      }

      isLoadingVerifyAccount = false;
      notifyListeners();
    }
  }
}
