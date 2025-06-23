import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/resources/validators.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/entities/gender_entity.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/domain/params/register_params.dart';
import 'package:irhebo/domain/params/send_otp_params.dart';
import 'package:irhebo/domain/usecases/auth_usecases/register_use_case.dart';
import 'package:irhebo/domain/usecases/auth_usecases/send_otp_use_case.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/network/end_points.dart';
import '../../../../app/network/network.dart';
import '../../../../app/snack_bar.dart';
import '../../../../domain/models/general_model.dart';
import '../../../../domain/models/new_models/general_data_model.dart';
import '../../../../domain/models/new_models/new_config_model.dart';

class RegisterController extends GetxController {
  final appController = Get.find<AppController>();
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  TextEditingController registerEmail = TextEditingController(
    text: Get.arguments != null
        ? (Get.arguments['google_user'] as GoogleSignInAccount?)?.email
        : null,
  );
  TextEditingController registerPassword = TextEditingController();
  TextEditingController registerPhone = TextEditingController();
  TextEditingController registerConfirmPassword = TextEditingController();
  TextEditingController registerUserName = TextEditingController(
    text: Get.arguments != null
        ? (Get.arguments['google_user'] as GoogleSignInAccount?)?.displayName
        : null,
  );
  RxInt score = (0).obs;

  final RxBool _registerIsVisibile = (false).obs;
  final RxBool _isLoading = (false).obs;

  bool get registerIsVisibile => _registerIsVisibile.value;

  bool get isLoading => _isLoading.value;

  set registerIsVisibile(value) => _registerIsVisibile.value = value;

  set isLoading(value) => _isLoading.value = value;

  GenderEntity? gender;
  NewConfigModelDataCountries? country;
  NewConfigModelDataProfessions? profession;
  RxList<NewConfigModelDataLanguagesData?> selectedLanguages =
      <NewConfigModelDataLanguagesData?>[].obs;

  @override
  onInit() async {
    super.onInit();
    if (isClosed) return;
  }

  onSelectGender(GenderEntity? val) {
    gender = val;
  }

  onConfirmLanguages(List<NewConfigModelDataLanguagesData?>? selected) {
    selectedLanguages.clear();
    if (selected!.isNotEmpty) {
      selectedLanguages.value = selected;
    }
  }

  onSelectProfession(NewConfigModelDataProfessions? val) {
    profession = val;
  }

  onSelectCountry(NewConfigModelDataCountries? val) {
    country = val;
  }

  onTapVisibile() {
    registerIsVisibile = !registerIsVisibile;
  }

  checkPasswordStrength(String holder) {
    score.value = AppValidators.passwordCriteriaVlidator(
      holder,
    );
    update();
  }

  onTapSignUp() async {
    if (signupKey.currentState!.validate()) {
      isLoading = true;
      //RegisterUseCase registerUseCase = sl();
      RegisterParams data;

      if (Get.arguments == null) {
        data = RegisterParams(
          username: registerUserName.text,
          confirmPassword: registerPassword.text,
          password: registerPassword.text,
          email: registerEmail.text,
          phone: registerPhone.text,
          prefix: appController.countryCode,
          professionId: profession?.id ?? 0,
          countryId: country?.id ?? 0,
          languages: selectedLanguages
              .map(
                (element) => element?.id ?? 0,
              )
              .toList(),
          gender: gender?.name?.toLowerCase() ?? '',
        );
      } else {
        String password = const Uuid().v4();
        data = RegisterParams(
          username: registerUserName.text,
          email: registerEmail.text,
          phone: registerPhone.text,
          googleId: Get.arguments['google_id'],
          prefix: appController.countryCode,
          professionId: profession?.id ?? 0,
          countryId: country?.id ?? 0,
          password: password,
          confirmPassword: password,
          languages: selectedLanguages
              .map(
                (element) => element?.id ?? 0,
              )
              .toList(),
          gender: gender?.name?.toLowerCase() ?? '',
        );
      }

      try {
        final response = await Network().post(
          url: AppEndpoints.register,
          data: data.toJson(),
        );
        String errorMessage = await Network().handelError(response: response);

        if (errorMessage.isNotEmpty) {
          isLoading = false;
          AppSnackBar.openErrorSnackBar(
            message: errorMessage,
          );
          return;
        }

        NewGeneralDataModel generalModel =
            NewGeneralDataModel.fromJson(response.data);

        if (generalModel.status == true) {
          isLoading = false;
          sendOtp();
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
        isLoading = false;
      }

      // final result = await registerUseCase(RegisterParams(
      //     username: registerUserName.text,
      //     confirmPassword: registerPassword.text,
      //     password: registerPassword.text,
      //     email: registerEmail.text,
      //     phone: registerPhone.text,
      //     prefix: appController.countryCode,
      //     professionId: profession?.id ?? 0,
      //     countryId: country?.id ?? 0,
      //     languages: selectedLanguages
      //         .map(
      //           (element) => element?.id ?? 0,
      //         )
      //         .toList(),
      //     gender: gender?.name ?? ""));
      // result!.fold((l) {
      //   isLoading = false;
      // }, (r) {
      //   isLoading = false;
      //   sendOtp();
      // });
    }
  }

  sendOtp() async {
    // SendOtpUseCase requestCodeUseCase = sl();
    // final result = await requestCodeUseCase(SendOtpParams(
    //     phone: registerPhone.text, prefix: appController.countryCode));
    // result!.fold((l) {}, (r) {
    //   Get.toNamed(AppRoutes.verification, arguments: {
    //     "verify_type": VerifyScreenType.register,
    //     "code": r.data!.code,
    //     "phone": registerPhone.text,
    //   });
    // });

    try {
      SendOtpParams data = SendOtpParams(
        phone: registerPhone.text,
        prefix: appController.countryCode,
      );
      final response = await Network().post(
        url: AppEndpoints.requestCode,
        data: data.toJson(),
      );

      String errorMessage = await Network().handelError(response: response);

      if (errorMessage.isNotEmpty) {
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }
      NewGeneralDataModel generalModel =
          NewGeneralDataModel.fromJson(response.data);
      if (generalModel.status == true) {
        Get.toNamed(AppRoutes.verification, arguments: {
          "verify_type": VerifyScreenType.register,
          "code": generalModel.data,
          "phone": registerPhone.text,
        });
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
    }
  }
}
