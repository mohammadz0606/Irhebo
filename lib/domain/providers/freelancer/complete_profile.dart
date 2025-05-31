import 'package:dio/dio.dart';
import 'package:irhebo/app/global_imports.dart';
import 'package:irhebo/domain/models/login_model.dart';

import '../../../app/network/network.dart';
import '../../../app/router/routes.dart';
import '../../params/new_params/freelanser/complete_profile_param.dart';

class CompleteProfileProvider extends ChangeNotifier {
  bool isLoading = false;
  final appController = Get.find<AppController>();
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

      ////
      LoginModel model = LoginModel.fromJson(response.data);

      appController.setAccessToken(model.token ?? '',model.user?.id ?? 0);
      AppPreferences prefs = sl();



      prefs.setString(
        key: AppPrefsKeys.USER_ROLE,
        value: model.user?.role ?? '',
      );

      Get.offAllNamed(AppRoutes.bottomNavBar);
      isLoading = false;
      notifyListeners();
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
}
