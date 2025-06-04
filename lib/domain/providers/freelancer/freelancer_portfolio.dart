import 'package:dio/dio.dart';
import 'package:irhebo/domain/models/new_models/general_model.dart';

import '../../../app/global_imports.dart';
import '../../../app/network/network.dart';
import '../../models/new_models/freelancer/portfolio_list_model.dart';
import '../../params/new_params/freelanser/create_portfolio_param.dart';
import '../../params/pagination_params.dart';

class FreelancerPortfolioProvider extends ChangeNotifier {
  bool isLoadingCreate = false;
  bool isLoadingUpdate = false;
  bool isLoadingDelete = false;
  bool isLoadingGet = false;

  int pageNumber = 1;
  List<PortfolioListModelDataPortfolios> portfolioList = [];

  Future<void> getPortfolioList() async {
    try {
      if (pageNumber == 1) {
        portfolioList.clear();
      }
      PaginationParams paginationParams =
          PaginationParams(page: pageNumber, perPage: AppConstants.PAGE_LENGTH);

      AppPreferences prefs = sl();

      final response = await Network().get(
        url: AppEndpoints.getPortfolio,
      );

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
      isLoadingGet = false;
      notifyListeners();
    }
  }

  Future<void> createPortfolio(CreatePortfolioParam data) async {
    try {
      isLoadingCreate = true;
      notifyListeners();
      final response = await Network().post(
        url: AppEndpoints.createPortfolio,
        isUploadFile: true,
        data: await data.toJson(),
      );
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingCreate = false;
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

      isLoadingCreate = false;
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
      isLoadingCreate = false;
      notifyListeners();
    }
  }

  Future<void> updatePortfolio(
    CreatePortfolioParam data, {
    required Function() onSuccess,
    required int id,
  }) async {
    try {
      isLoadingUpdate = true;
      notifyListeners();
      final response = await Network().post(
        url: '${AppEndpoints.updatePortfolio}$id',
        isUploadFile: true,
        data: await data.toJson(),
      );
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingUpdate = false;
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
          message: 'Portfolio update successfully'.tr,
        );
        onSuccess();
      }

      isLoadingUpdate = false;
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
      isLoadingUpdate = false;
      notifyListeners();
    }
  }

  Future<void> deletePortfolio({
    required Function() onSuccess,
    required int id,
  }) async {
    try {
      isLoadingDelete = true;
      notifyListeners();
      final response = await Network().delete(
        url: '${AppEndpoints.deletePortfolio}$id',
      );
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoadingDelete = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }

      NewGeneralModel newGeneralModel = NewGeneralModel.fromJson(response.data);
      if (newGeneralModel.status ?? false) {
        AppSnackBar.openSuccessSnackBar(
          message: 'Portfolio delete successfully'.tr,
        );
        onSuccess();
      }

      isLoadingDelete = false;
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
      isLoadingDelete = false;
      notifyListeners();
    }
  }
}
