import 'package:dio/dio.dart';
import 'package:irhebo/presentation/screens/service_details/service_details_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../app/global_imports.dart';
import '../../../app/network/network.dart';
import '../../models/new_models/freelancer/freelancer_service_model.dart';
import '../../models/new_models/general_model.dart';
import '../../models/service_details_model.dart';
import '../../params/new_params/freelanser/freelancer_service_param.dart';
import '../../usecases/home_usecases/get_service_details_use_case.dart';

class FreelancerServicesProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadingGetDetails = false;
  FreelancerServiceModel? freelancerServiceModel;
  ServiceDetailsModel? serviceDetails;

  int pageNumber = 1;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List<FreelancerServiceModelDataServices?>? services = [];

  bool isLoadingDelete = false;

  Future<void> getFreeLancerServices({
    required FreelancerServiceParam data,
    bool enablePagination = false,
  }) async {
    try {
      isLoading = true;
      if (this.freelancerServiceModel != null) {
        this.freelancerServiceModel = null;
      }
      if (pageNumber == 1 && enablePagination) {
        services?.clear();
      }
      notifyListeners();
      AppPreferences prefs = sl();
      final response = await Network().get(
        url: AppEndpoints.servicesByUser,
        query: enablePagination
            ? data.toJson()
            : {
                "user_id": prefs.getInt(key: AppPrefsKeys.USER_ID),
              },
      );

      String errorMessage = await Network().handelError(response: response);

      if (errorMessage.isNotEmpty) {
        isLoading = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        if (enablePagination) {
          refreshController.refreshFailed();
        }
        return;
      }
      FreelancerServiceModel freelancerServiceModel =
          FreelancerServiceModel.fromJson(response.data);
      if (enablePagination) {
        pageNumber = pageNumber + 1;
        services?.addAll(freelancerServiceModel.data?.services ?? []);

        if (freelancerServiceModel.data?.services?.isEmpty == true) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        if (freelancerServiceModel.status == true) {
          this.freelancerServiceModel = freelancerServiceModel;
        }
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

  Future<void> onRefreshList() async {
    pageNumber = 1;
    services?.clear();
    await getFreeLancerServices(
      enablePagination: true,
      data: FreelancerServiceParam(
        prePage: AppConstants.PAGE_LENGTH,
        page: pageNumber,
      ),
    );
    refreshController.refreshCompleted();
    refreshController.refreshToIdle();
  }

  Future<void> deleteService({
    required Function() onSuccess,
    required int id,
  }) async {
    try {
      isLoadingDelete = true;
      notifyListeners();
      final response = await Network().delete(
        url: '${AppEndpoints.deleteService}$id',
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

  Future<void> getServicesDetails({
    required int id,
    required Function(ServiceDetailsModel serviceDetails) onSuccess,
  }) async {
    try {
      if(serviceDetails != null) {
        serviceDetails = null;
      }
      isLoadingGetDetails = true;
      notifyListeners();
      // Get.put(ServiceDetailsController());
      // Get.find<ServiceDetailsController>().getServiceDetails(id);

      GetServiceDetailsUseCase getServiceDetailsUseCase = sl();
      final result = await getServiceDetailsUseCase(id);
      result!.fold((l) {
        isLoadingGetDetails = false;
        notifyListeners();
      }, (r) {
        onSuccess(r.data ?? ServiceDetailsModel());
        serviceDetails = r.data;
        isLoadingGetDetails = false;
        notifyListeners();
      });
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
      isLoadingGetDetails = false;
      notifyListeners();
    }
  }




}
