import 'package:dio/dio.dart';
import 'package:irhebo/domain/models/new_models/general_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../app/global_imports.dart';
import '../../../app/network/network.dart';
import '../../models/config_model.dart';
import '../../models/new_models/freelancer/portfolio_list_model.dart';
import '../../params/new_params/freelanser/create_portfolio_param.dart';
import '../../params/pagination_params.dart';

class FreelancerPortfolioProvider extends ChangeNotifier {
  bool isLoadingCreate = false;
  bool isLoadingUpdate = false;
  bool isLoadingDelete = false;
  bool isLoadingGet = false;
  bool isLoadingDetails = false;

  int pageNumber = 1;
  List<PortfolioListModelDataPortfolios> portfolioList = [];
  DataModel? portfolio;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> getPortfolioList() async {
    try {
      isLoadingGet = true;
      if (pageNumber == 1) {
        portfolioList.clear();
      }
      notifyListeners();
      PaginationParams paginationParams =
          PaginationParams(page: pageNumber, perPage: AppConstants.PAGE_LENGTH);

      AppPreferences prefs = sl();

      final response =
          await Network().get(url: AppEndpoints.getPortfolio, query: {
        'user_id': '${prefs.getInt(key: AppPrefsKeys.USER_ID)}',
        'per_page': paginationParams.perPage,
        'page': paginationParams.page,
      });

      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        refreshController.refreshFailed();
        return;
      }
      pageNumber = pageNumber + 1;
      PortfolioListModel portfolioListModel =
          PortfolioListModel.fromJson(response.data);

      portfolioList.addAll(
        portfolioListModel.data?.portfolios ?? [],
      );
      if (portfolioListModel.data?.portfolios?.isEmpty == true) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      isLoadingGet = false;
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
      isLoadingGet = false;
      notifyListeners();
    }
  }

  Future<void> onRefreshList() async {
    pageNumber = 1;
    portfolioList.clear();
    await getPortfolioList();
    refreshController.refreshCompleted();
    refreshController.refreshToIdle();
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
        await onRefreshList();
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
        await onRefreshList();
        //onSuccess();
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

  Future<void> getPortfolioDetails(int id) async {
    try {
      isLoadingDetails = true;
      if (portfolio != null) {
        portfolio = null;
      }
      notifyListeners();

      final response = await Network().get(
        url: '${AppEndpoints.portfolioDetails}$id',
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

      DataModel dataModel = DataModel.fromJson(response.data);
      portfolio = dataModel;
      isLoadingDetails = false;
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
      isLoadingDetails = false;
      notifyListeners();
    }
  }
}
