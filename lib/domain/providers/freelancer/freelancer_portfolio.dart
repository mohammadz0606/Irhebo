import 'package:dio/dio.dart';
import 'package:irhebo/domain/models/new_models/general_model.dart';

import '../../../app/global_imports.dart';
import '../../../app/network/network.dart';
import '../../params/new_params/freelanser/create_portfolio_param.dart';

class FreelancerPortfolioProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<void> createPortfolio(CreatePortfolioParam data) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await Network().post(
        url: AppEndpoints.createPortfolio,
        isUploadFile: true,
        data: await data.toJson(),
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

      NewGeneralModel newGeneralModel = NewGeneralModel.fromJson(response.data);
      if (newGeneralModel.status ?? false) {
        Get.back();
        AppSnackBar.openSuccessSnackBar(
          message: 'Portfolio created successfully'.tr,
        );
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
