import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/domain/entities/gender_entity.dart';
import 'package:irhebo/domain/models/config_model.dart';

import '../../domain/models/new_models/new_config_model.dart';

///
/// Validator class
///
class AppValidators {
  static String? validateName(String? name) {
    if (name!.isEmpty) {
      return Get.find<AppController>().lang.value.languageCode ==
              AppLanguage.ar.name
          ? "حقل الاسم مطلوب"
          : "The Name field is required";
    }
    return null;
  }

  static String? validateReview(String? name) {
    if (name!.isEmpty) {
      return Get.find<AppController>().lang.value.languageCode ==
              AppLanguage.ar.name
          ? "الرجاء اكتب تقييما"
          : "please write a review";
    } else if (name.length < 25) {
      return Get.find<AppController>().lang.value.languageCode ==
              AppLanguage.ar.name
          ? "اكتب ٢٥ حرفا علي الأقل"
          : "write 25 characters at least";
    }
    return null;
  }

  static String? validateSearch(String? name) {
    if (name!.isEmpty || name.length < 3) {
      return Get.find<AppController>().lang.value.languageCode ==
              AppLanguage.ar.name
          ? "أدخل ٣ أحرف على الأقل"
          : "enter 3 characters at least";
    }
    return null;
  }

  static int passwordCriteriaVlidator(
    String holder,
  ) {
    // if (password.text.isNotEmpty) score += 1;
    int score = 0;
    if (holder.length >= 8) score += 1;
    if (holder.contains(RegExp(r'[a-z]'))) score += 1;
    if (holder.contains(RegExp(r'[A-Z]'))) score += 1;
    if (holder.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score += 1;
    return score;
  }

  static String? validateOtp(String? name) {
    if (name!.isEmpty) {
      return Get.find<AppController>().lang.value.languageCode ==
              AppLanguage.ar.name
          ? "الرجاء ادخال الرمز المرسل"
          : "please enter sent sotp";
    }
    return null;
  }

  static String? validateLanguage(DataModel? name) {
    if (name == null) {
      return Get.find<AppController>().lang.value.languageCode ==
              AppLanguage.ar.name
          ? "حقل اللغة مطلوب"
          : "The language field is required";
    }
    return null;
  }

  static String? languagesValidator(List<NewConfigModelDataLanguagesData?>? selected) {
    if (selected!.isEmpty) {
      return Get.find<AppController>().lang.value.languageCode ==
              AppLanguage.ar.name
          ? "الرجاء اختيار لغة واحدة على الأقل"
          : "Please choose one language at least";
    }

    return null;
  }

  static String? validateProfession(NewConfigModelDataProfessions? name) {
    if (name == null) {
      return Get.find<AppController>().lang.value.languageCode ==
              AppLanguage.ar.name
          ? "حقل المهنة مطلوب"
          : "The profession field is required";
    }
    return null;
  }

  static String? validateStatus(String? name) {
    if (name == null) {
      return Get.find<AppController>().lang.value.languageCode ==
              AppLanguage.ar.name
          ? "حقل الحالة مطلوب"
          : "The status field is required";
    }
    return null;
  }

  static String? validateCountry(NewConfigModelDataCountries? name) {
    if (name == null) {
      return Get.find<AppController>().lang.value.languageCode ==
              AppLanguage.ar.name
          ? "حقل البلد مطلوب"
          : "The country field is required";
    }
    return null;
  }

  static String? validateGender(GenderEntity? name) {
    if (name == null) {
      return Get.find<AppController>().lang.value.languageCode ==
              AppLanguage.ar.name
          ? "حقل الجنس مطلوب"
          : "The gender field is required";
    }
    return null;
  }

  static String? validateNewPassword(String? password) {
    if (password == null || password.isEmpty) {
      return Get.find<AppController>().lang.value.languageCode ==
              AppLanguage.en.name
          ? "The Password field is required"
          : "حقل كلمة السر مطلوب";
    }

    if (password.length < 8) {
      return Get.find<AppController>().lang.value.languageCode ==
              AppLanguage.en.name
          ? ""
          : "";
    } else {
      String pattern =
          r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#^_+=-]).{8,}$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(password)) {
        return Get.find<AppController>().lang.value.languageCode ==
                AppLanguage.en.name
            ? ""
            : "";
      }
    }

    return null;
  }

  static String? validatePasswordConf(String? confirmedPass, newPass) {
    {
      if (confirmedPass!.isEmpty) {
        return Get.find<AppController>().lang.value.languageCode ==
                AppLanguage.ar.name
            ? "حقل تأكيد كلمة السر مطلوب"
            : "The confirm password field is required";
      }
      if (confirmedPass != newPass) {
        return Get.find<AppController>().lang.value.languageCode ==
                AppLanguage.ar.name
            ? "كلمة المرور غير متطابقة"
            : "The Password doesn`t match";
      }
      return null;
    }
  }
  // static String? validateValueSignUpForm(String? name, String value) {
  //   if (value.isEmpty) {
  //     return Get.find<AppController>().lang.value.languageCode == "ar"
  //         ? "حقل $name مطلوب"
  //         : "The $name field is required";
  //     //return '';
  //   } else {
  //     if (value.length < 3) {
  //       return Get.find<AppController>().lang.value.languageCode == "ar"
  //           ? "حقل $name لا يمكن أن يكون اقل من 3 حروف "
  //           : "The $name  cannot be less than 3 characters";
  //     }
  //   }
  //   return null;
  // }

  // static String? validateSearch(String? word) {
  //   if (word!.isEmpty) {
  //     return Get.find<AppController>().lang.value.languageCode == "ar"
  //         ? "حقل الاسم مطلوب"
  //         : "The Name field is required";
  //     //return '';
  //   } else if (word.length < 3) {
  //     return Get.find<AppController>().lang.value.languageCode == "ar"
  //         ? "ادخل ثلاثة حروف على الأقل"
  //         : "you must enter three characters at least";
  //   } else {
  //     return null;
  //   }
  // }

  // static String? validateMessage(String? name) {
  //   if (name!.isEmpty) {
  //     return Get.find<AppController>().lang.value.languageCode == "ar"
  //         ? "حقل الرسالة مطلوب"
  //         : "The Message field is required";
  //     //return '';
  //   }
  //   return null;
  // }

  static String? validateEmail(String? email) {
    if (email!.isEmpty) {
      return Get.find<AppController>().lang.value.languageCode ==
              AppLanguage.ar.name
          ? "حقل البريد الإلكتروني مطلوب"
          : "The email field is required";
    }

    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(email)) {
      return Get.find<AppController>().lang.value.languageCode == "ar"
          ? "أدخل بريد إلكتروني صالح"
          : "Enter Valid Email";
    }
    return null;
  }

  static String? validatePhone(
    String? phone,
  ) {
    if (phone!.isEmpty) {
      return Get.find<AppController>().lang.value.languageCode == "ar"
          ? "حقل رقم الهاتف مطلوب"
          : "The Phone Number field is required";
      //return '';
    }
    // else if (phone.length < 8 && code == "+966") {
    //   return Get.find<AppController>().lang.value.languageCode == "ar"
    //       ? "أدخل رقم هاتف صالح"
    //       : "Enter Valid Phone Number";
    // }
    return null;
    // RegExp validNumbers = RegExp(r'[0-9]');
    // // RegExp validNumbers2 =
    // // RegExp(r'^[_\-=@,\.;]+$');
    // // log("${code}validatePhone");
    // if (phone!.isEmpty) {
    //   return Get.find<AppController>().lang.value.languageCode == "ar"
    //       ? "حقل رقم الهاتف مطلوب"
    //       : "The Phone Number field is required";
    //   //return '';
    // } else if (phone.contains('-')) {
    //   return Get.find<AppController>().lang.value.languageCode == "ar"
    //       ? "الرجاء إدخال رقم صحيح"
    //       : "Please Enter Valid Number";
    // } else if (phone.contains('.')) {
    //   return Get.find<AppController>().lang.value.languageCode == "ar"
    //       ? "الرجاء إدخال رقم صحيح"
    //       : "Please Enter Valid Number";
    // } else if (!validNumbers.hasMatch(phone)) {
    //   return Get.find<AppController>().lang.value.languageCode == "ar"
    //       ? "الرجاء إدخال رقم صحيح"
    //       : "Please Enter Valid Number";
    // } else if (phone.length < 9 && code == "+963") {
    //   return Get.find<AppController>().lang.value.languageCode == "ar"
    //       ? "أدخل رقم هاتف صالح"
    //       : "Enter Valid Phone Number";
    // }
    // return null;
  }

  // static String? validateSecondaryPhone(String? phone, String? code) {
  //   RegExp validNumbers = RegExp(r'[0-9]');
  //   // RegExp validNumbers2 =
  //   // RegExp(r'^[_\-=@,\.;]+$');
  //   // log("${code}validatePhone");
  //   // if (phone!.isEmpty) {
  //   //   return Get.find<AppController>().lang.value.languageCode == "ar"
  //   //       ? "حقل رقم الهاتف مطلوب"
  //   //       : "The Phone Number field is required";
  //   //   //return '';
  //   // }
  //   if (phone == null || phone.isEmpty) {
  //     return null;
  //   }
  //   if (phone.contains('-')) {
  //     return Get.find<AppController>().lang.value.countryCode == "ar"
  //         ? "الرجاء إدخال رقم صحيح"
  //         : "Please Enter Valid Number1";
  //   } else if (phone.contains('.')) {
  //     return Get.find<AppController>().lang.value.languageCode == "ar"
  //         ? "الرجاء إدخال رقم صحيح"
  //         : "Please Enter Valid Number2";
  //   } else if (!validNumbers.hasMatch(phone)) {
  //     return Get.find<AppController>().lang.value.languageCode == "ar"
  //         ? "الرجاء إدخال رقم صحيح"
  //         : "Please Enter Valid Number3";
  //   } else if (phone.length < 9 && code == "+963") {
  //     return Get.find<AppController>().lang.value.languageCode == "ar"
  //         ? "أدخل رقم هاتف صالح"
  //         : "Enter Valid Phone Number4";
  //   }
  //   return null;
  // }

  // static String? validateAddress(String? address) {
  //   if (address!.isEmpty) {
  //     return Get.find<AppController>().lang.value.languageCode == "ar"
  //         ? "حقل العنوان مطلوب"
  //         : "The Address field is required";

  //     //return '';
  //   }
  //   return null;
  // }

  // static String? validateCity(String? address) {
  //   if (address!.isEmpty) {
  //     return Get.find<AppController>().lang.value.languageCode == "ar"
  //         ? "حقل المدينة مطلوب"
  //         : "The City field is required";

  //     //return '';
  //   }
  //   return null;
  // }

  static String? validatePassword(String? password) {
    {
      if (password!.isEmpty) {
        return Get.find<AppController>().lang.value.languageCode == "ar"
            ? "حقل كلمة السر مطلوب"
            : "The Password field is required";
      }
      return null;
    }
  }

  static String? validateField(String? value) {
    {
      if (value!.isEmpty) {
        return Get.find<AppController>().lang.value.languageCode == "ar"
            ? "هذا الحقل مطلوب"
            : "This field is required";
      }
      return null;
    }
  }

  // // static String? validateLoginPassword(String? password) {
  // //   if (password!.isEmpty) {
  // //     return Get.find<AppController>().lang.value.languageCode == "ar" ? "حقل كلمة السر مطلوب" : "The Password field is required";
  // //   } else {
  // //     // String pattern =
  // //     //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
  // //     String pattern = r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{6,}$';
  // //     RegExp regExp = RegExp(pattern);
  // //     if (!regExp.hasMatch(password)) {
  // //       return Get.find<AppController>().lang.value.languageCode == "ar"
  // //           ? "يجب أن تحتوي كلمة المرور على  6 أحرف وأرقام على الأقل"
  // //           : "Password should contain digit and at least 6 characters";
  // //     } else {
  // //       return null;
  // //     }
  // //   }
  // // }

  // static String? validateprice(String? password) {
  //   {
  //     if (password!.isEmpty) {
  //       return Get.find<AppController>().lang.value.languageCode == "ar"
  //           ? "حقل كلمة السعر مطلوب"
  //           : "The Price field is required";
  //     } else {
  //       return null;
  //     }
  //   }
  // }

  // static String? validateInstitute(String? name) {
  //   if (name!.isEmpty) {
  //     return Get.find<AppController>().lang.value.languageCode == "ar"
  //         ? "حقل ${"Institute Name".tr} مطلوب"
  //         : "The ${"Institute Name".tr} field is required";
  //     //return '';
  //   }
  //   return null;
  // }

  // static String? validateSpecialty(String? name) {
  //   if (name!.isEmpty) {
  //     return Get.find<AppController>().lang.value.languageCode == "ar"
  //         ? "حقل ${"specialty".tr} مطلوب"
  //         : "The ${"specialty".tr} field is required";
  //     //return '';
  //   }
  //   return null;
  // }

  // static String? validateNumberOfReplays(String? name) {
  //   if (name!.isEmpty) {
  //     return Get.find<AppController>().lang.value.languageCode == "ar"
  //         ? "حقل ${"Number Of Replays".tr} مطلوب"
  //         : "The ${"Number Of Replays".tr} field is required";
  //     //return '';
  //   }
  //   return null;
  // }

  // static String? validateValue(String? name, String value) {
  //   if (value.isEmpty) {
  //     return Get.find<AppController>().lang.value.languageCode == "ar"
  //         ? "حقل $name مطلوب"
  //         : "The $name field is required";
  //     //return '';
  //   }
  //   return null;
  // }
}
