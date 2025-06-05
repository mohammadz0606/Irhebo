import 'package:dio/dio.dart';

import '../../../app/global_imports.dart';
import '../../../app/network/network.dart';
import '../../models/new_models/freelancer/freelancer_user.dart';

class FreelancerProfileProvider extends ChangeNotifier {
  UserFreelancerModelData? userFreelancerModelData;

  bool isLoading = false;

  getFreelancerProfile() async {
    try {
      isLoading = true;
      if (userFreelancerModelData != null) {
        userFreelancerModelData = null;
      }

      notifyListeners();
      final response = await Network().get(
        url: AppEndpoints.getFreelancerProfile,
      );
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoading = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(message: errorMessage);
        return;
      }

      UserFreelancerModel freelancerProfileModel =
          UserFreelancerModel.fromJson(response.data);

      if (freelancerProfileModel.status ?? false) {
        userFreelancerModelData = freelancerProfileModel.data;
      }
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
