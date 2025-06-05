import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:irhebo/domain/models/new_models/currency_model.dart';

import '../../app/global_imports.dart';
import '../../app/network/network.dart';
import '../../app/router/routes.dart';

class CurrencyProvider extends ChangeNotifier {
  bool isLoading = true;

  CurrencyModel? currencyModel;

  getCurrencies() async {
    try {
      if (currencyModel != null) {
        currencyModel = null;
      }
      isLoading = true;
      notifyListeners();
      final response = await Network().get(url: AppEndpoints.currencies);

      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoading = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }

      currencyModel = CurrencyModel.fromJson(response.data);
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


  onChangeCurrency(String value) async {
    log('MY VALUE IS A $value');
    await AppPreferences(sl()).setString(
      key: AppPrefsKeys.CURRENCY,
      value: value,
    );
    Get.offAllNamed(AppRoutes.splash);
    notifyListeners();
  }
}
