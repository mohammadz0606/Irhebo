import 'package:dio/dio.dart';
import 'package:irhebo/app/global_imports.dart';

import '../../../app/network/network.dart';
import '../../params/new_params/freelanser/complete_profile_param.dart';

class CompleteProfileProvider extends ChangeNotifier {
  bool isLoading = false;

  completeProfile({required CompleteProfileParam data}) async {
    try {
      isLoading = true;
      final response = await Network()
          .post(url: AppEndpoints.completeProfile, data: await data.toJson());

      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoading = false;
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }

      ////

      isLoading = false;
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
    }
  }
}
