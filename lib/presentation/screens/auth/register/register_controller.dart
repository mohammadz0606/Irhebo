import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class RegisterController extends GetxController {
  final appController = Get.find<AppController>();
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  TextEditingController registerEmail = TextEditingController();
  TextEditingController registerPassword = TextEditingController();
  TextEditingController registerPhone = TextEditingController();
  TextEditingController registerConfirmPassword = TextEditingController();
  TextEditingController registerUserName = TextEditingController();
  RxInt score = (0).obs;

  final RxBool _registerIsVisibile = (false).obs;
  final RxBool _isLoading = (false).obs;

  bool get registerIsVisibile => _registerIsVisibile.value;
  bool get isLoading => _isLoading.value;

  set registerIsVisibile(value) => _registerIsVisibile.value = value;
  set isLoading(value) => _isLoading.value = value;

  GenderEntity? gender;
  DataModel? country;
  ProfessionModel? profession;
  RxList<DataModel?> selectedLanguages = <DataModel?>[].obs;

  @override
  onInit() async {
    super.onInit();
    if (isClosed) return;
  }

  onSelectGender(GenderEntity? val) {
    gender = val;
  }

  onConfirmLanguages(List<DataModel?>? selected) {
    selectedLanguages.clear();
    if (selected!.isNotEmpty) {
      selectedLanguages.value = selected;
    }
  }

  onSelectProfession(ProfessionModel? val) {
    profession = val;
  }

  onSelectCountry(DataModel? val) {
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
      RegisterUseCase registerUseCase = sl();
      final result = await registerUseCase(RegisterParams(
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
          gender: gender?.name ?? ""));
      result!.fold((l) {
        isLoading = false;
      }, (r) {
        isLoading = false;
        sendOtp();
      });
    }
  }

  sendOtp() async {
    SendOtpUseCase requestCodeUseCase = sl();
    final result = await requestCodeUseCase(SendOtpParams(
        phone: registerPhone.text, prefix: appController.countryCode));
    result!.fold((l) {}, (r) {
      Get.toNamed(AppRoutes.verification, arguments: {
        "verify_type": VerifyScreenType.register,
        "code": r.data!.code,
        "phone": registerPhone.text,
      });
    });
  }
}
