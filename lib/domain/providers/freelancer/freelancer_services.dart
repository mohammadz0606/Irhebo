import 'package:dio/dio.dart';

import '../../../app/global_imports.dart';
import '../../../app/network/network.dart';
import '../../models/new_models/freelancer/freelancer_service_model.dart';
import '../../params/new_params/freelanser/freelancer_service_param.dart';

class FreelancerServicesProvider extends ChangeNotifier {
  bool isLoading = false;
  FreelancerServiceModel? freelancerServiceModel;

  Future<void> getFreeLancerServices({
    required FreelancerServiceParam data,
  }) async {
    try {
      isLoading = true;
      if (this.freelancerServiceModel != null) {
        this.freelancerServiceModel = null;
      }
      notifyListeners();
      AppPreferences prefs = sl();
      final response = await Network().get(
        url: AppEndpoints.servicesByUser,
        //query: data.toJson(),
        query: {
          "user_id": prefs.getInt(key: AppPrefsKeys.USER_ID),
        }
      );

      String errorMessage = await Network().handelError(response: response);

      if (errorMessage.isNotEmpty) {
        isLoading = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }

      FreelancerServiceModel freelancerServiceModel =
          FreelancerServiceModel.fromJson(response.data);

      if (freelancerServiceModel.status == true) {
        this.freelancerServiceModel = freelancerServiceModel;
        isLoading = false;
        notifyListeners();
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
      notifyListeners();
    }
  }
}
