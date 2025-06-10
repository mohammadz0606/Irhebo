import 'package:dio/dio.dart';

import '../../app/global_imports.dart';
import '../../app/network/network.dart';

class MediaProvider extends ChangeNotifier {
  bool isLoading = false;

  deleteMedia({
    required int id,
    required Function() onSuccess,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final response =
          await Network().delete(url: '${AppEndpoints.deleteMedia}$id');

      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoading = false;
        notifyListeners();
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }

      isLoading = false;
      onSuccess();
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
