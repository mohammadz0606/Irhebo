import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:irhebo/app/global_imports.dart';
import 'package:irhebo/domain/models/login_model.dart';

import '../../app/network/network.dart';
import '../../app/router/routes.dart';

class SocialAuthProvider extends ChangeNotifier {
  bool isLoadingGoogle = false;

  Future<void> googleAuth() async {
    try {
      isLoadingGoogle = true;
      notifyListeners();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleUser?.id != null) {
        log('--------------------------');
        log(googleAuth?.idToken ?? '');
        log('--------------------------');
        log(googleAuth?.accessToken ?? '');
        log('--------------------------');

        final response =
            await Network().post(url: AppEndpoints.socialLogin, data: {
          'google_id': googleUser?.id,
        });
        String errorMessage = await Network().handelError(response: response);
        if (errorMessage.isNotEmpty) {
          isLoadingGoogle = false;
          notifyListeners();
          AppSnackBar.openErrorSnackBar(
            message: errorMessage,
          );
          return;
        }

        if (response.data['data'] != null) {
          LoginModel loginModel = LoginModel.fromJson(response.data['data']);
          final appController = Get.find<AppController>();

          appController.setAccessToken(
            loginModel.token ?? '',
            loginModel.user?.id ?? 0,
          );
          AppPreferences prefs = sl();
          prefs.setString(
            key: AppPrefsKeys.USER_ROLE,
            value: loginModel.user?.role ?? '',
          );

          prefs.setBoolValue(
            loginModel.user?.isNotifiable == 1,
            AppPrefsKeys.IS_NOTIFIABLE,
          );

          Get.offAllNamed(AppRoutes.bottomNavBar);
        } else {
          Get.toNamed(AppRoutes.register, arguments: {
            'isSocial': true,
            'google_id': googleUser?.id,
            'google_user': googleUser,
          });
        }
      }

      isLoadingGoogle = false;
      notifyListeners();

      //LoginModel
    } catch (error) {
      AppSnackBar.openErrorSnackBar(message: error.toString());
      isLoadingGoogle = false;
      log(error.toString());
      notifyListeners();
    }
  }
}
