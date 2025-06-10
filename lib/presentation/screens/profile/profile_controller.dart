import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/global_imports.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/domain/entities/gender_entity.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/domain/params/update_profile_params.dart';
import 'package:irhebo/domain/usecases/setting_usecase/get_my_profile_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/update_profile_picture_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/update_profile_use_case.dart';
import 'package:irhebo/presentation/screens/profile/update_profile_screen.dart';

import '../../../app/network/end_points.dart';
import '../../../app/network/network.dart';
import '../../../app/snack_bar.dart';
import '../../../domain/models/new_models/freelancer/freelancer_user.dart';
import '../../../domain/models/new_models/new_config_model.dart';
import '../auth/register/register_freelancer_screen.dart';

class ProfileController extends GetxController {
  final appController = Get.find<AppController>();

  final RxBool _isLoading = false.obs;
  final RxBool _isLoadingUpdate = false.obs;
  final RxString _imagePath = "".obs;

  bool get isLoading => _isLoading.value;

  bool get isLoadingUpdate => _isLoadingUpdate.value;

  String get imagePath => _imagePath.value;

  set isLoading(value) => _isLoading.value = value;

  set isLoadingUpdate(value) => _isLoadingUpdate.value = value;

  set imagePath(value) => _imagePath.value = value;

  final GlobalKey<FormState> updateProfileKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController userName = TextEditingController();
  GenderEntity? gender;
  NewConfigModelDataCountries? country;
  NewConfigModelDataProfessions? profession;
  RxList<NewConfigModelDataLanguagesData?> selectedLanguages =
      <NewConfigModelDataLanguagesData?>[].obs;

  UserModel? user;
  UserFreelancerModelData? userFreelancerModelData;

  dio.MultipartFile? imageProfile;
  late Uint8List? imageBytes;

  @override
  onInit() async {
    super.onInit();
    if (getUserRole == UserRoles.freelancer) {
      await getFreelancerProfile().then(
        (value) => initFieldsValues(),
      );
    } else {
      await getMyProfile().then(
        (value) => initFieldsValues(),
      );
    }
  }

  getFreelancerProfile() async {
    try {
      isLoading = true;
      if (userFreelancerModelData != null || user != null) {
        userFreelancerModelData = null;
        user = null;
      }
      final response = await Network().get(
        url: AppEndpoints.getFreelancerProfile,
      );
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoading = false;
        AppSnackBar.openErrorSnackBar(message: errorMessage);
      }

      UserFreelancerModel freelancerProfileModel =
          UserFreelancerModel.fromJson(response.data);

      if (freelancerProfileModel.status ?? false) {
        userFreelancerModelData = freelancerProfileModel.data;
        user = UserModel(
          avatar: userFreelancerModelData?.freelancer?.avatar,
          country: userFreelancerModelData?.freelancer?.country,
          email: userFreelancerModelData?.freelancer?.email,
          fullPhone: userFreelancerModelData?.freelancer?.fullPhone,
          gender: userFreelancerModelData?.freelancer?.gender,
          id: userFreelancerModelData?.freelancer?.id,
          languages: userFreelancerModelData?.freelancer?.languages,
          name: userFreelancerModelData?.freelancer?.name,
          phone: userFreelancerModelData?.freelancer?.phone,
          prefix: userFreelancerModelData?.freelancer?.prefix,
          profession: userFreelancerModelData?.freelancer?.profession,
          role: userFreelancerModelData?.freelancer?.role,
        );
      }
      isLoading = false;
    } catch (error) {
      if (error is dio.DioException) {
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
  }

  getMyProfile() async {
    isLoading = true;
    user = null;
    GetMyProfileUseCase getMyProfileUseCase = sl();
    final result = await getMyProfileUseCase(());
    result!.fold((l) {
      isLoading = false;
    }, (r) {
      user = r.data;
      isLoading = false;
    });
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

  updateProfile() async {
    isLoadingUpdate = true;

    UpdateProfileUseCase updateProfileUseCase = sl();
    final result = await updateProfileUseCase(UpdateProfileParams(
      countryId: country?.id ?? 0,
      professionId: profession?.id ?? 0,
      languages: selectedLanguages
          .map(
            (element) => element?.id ?? 0,
          )
          .toList(),
      gender: gender?.name?.toLowerCase() ?? "",
      username: userName.text,
    ));
    result!.fold((l) {
      isLoadingUpdate = false;
    }, (r) {
      if (UserRoles.freelancer == getUserRole) {
        getFreelancerProfile();
      } else {
        getMyProfile();
      }
      isLoadingUpdate = false;
    });
  }

  initFieldsValues() {
    email.text = user?.email ?? "";
    userName.text = user?.name ?? "";
    phone.text = user?.phone ?? "";

    selectedLanguages.clear();
    if (getUserRole == UserRoles.freelancer) {
      country = appController.countries.firstWhere(
        (element) =>
            element?.title ==
            (userFreelancerModelData?.freelancer?.country ?? ''),
      );
      selectedLanguages.addAll(appController.languages.where((lang) =>
          userFreelancerModelData?.freelancer?.languages
              ?.any((uLang) => uLang.id == lang?.id) ??
          false));
      profession = appController.professions.firstWhere(
        (element) =>
            element?.title?.toLowerCase() ==
            (userFreelancerModelData?.freelancer?.profession?.toLowerCase() ??
                0),
        orElse: () {
          return NewConfigModelDataProfessions();
        },
      );
      gender = appController.genders.firstWhere(
        (element) =>
            element.name?.toLowerCase() ==
            (userFreelancerModelData?.freelancer?.gender?.toLowerCase() ?? ''),
      );
    } else {
      country = appController.countries.firstWhere(
        (element) => element?.id == (user?.countryObject?.id ?? 0),
      );
      selectedLanguages.addAll(appController.languages.where((lang) =>
          user?.languages?.any((uLang) => uLang.id == lang?.id) ?? false));
      profession = appController.professions.firstWhere(
        (element) => element?.id == (user?.professionObject?.id ?? 0),
      );
      gender = appController.genders.firstWhere(
        (element) =>
            element.name?.toLowerCase() == (user?.gender?.toLowerCase() ?? ''),
      );
    }

    // for (LanguageModel element in user?.languages ?? []) {
    //   final matched = appController.languages.firstWhereOrNull((lang) => lang?.id == element.id);
    //   if (matched != null) selectedLanguages.add(matched);
    // }
  }

  updateProfileButton({bool forPicture = false}) {
    if (forPicture) {
      if (imageProfile != null) {
        updateProfilePicture();
      }
    } else {
      if (updateProfileKey.currentState!.validate()) {
        updateProfile();
      }
    }
  }

  updateProfilePicture() async {
    isLoadingUpdate = true;
    UpdateProfilePictureUseCase updateProfilePictureUseCase = sl();
    final result = await updateProfilePictureUseCase(UpdateProfileParams(
        avatar:
            imageProfile!.isFinalized ? imageProfile!.clone() : imageProfile));
    result!.fold((l) {
      isLoadingUpdate = false;
    }, (r) {
      getMyProfile();
      isLoadingUpdate = false;
    });
  }

  pickPicture() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((value) async {
      if (value != null) {
        imageBytes = await value.readAsBytes();
        File file = File(value.path);
        imagePath = file.path;
        var fileName = imagePath.split('/').last;
        imageProfile = await dio.MultipartFile.fromFile(
          file.path,
          filename: fileName,
        );
      }
    });
  }

  goToUpdate() async {
    await Get.to(
      () => UpdateProfileScreen(
        user: user,
        isUpdate: true,
      ),
    );
  }

  goToUpdateFreelancerDetails() async {
    await Get.to(
      () => RegisterFreelancerScreen(
        userFreelancerModelData: userFreelancerModelData,
      ),
    );
  }
}
