import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/snack_bar.dart';

class ConnectionManagerController extends GetxController {
  //0 = No Internet, 1 = WIFI Connected ,2 = Mobile Data Connected.
  var connectionType = 5.obs;

  final Connectivity _connectivity = sl();

  late StreamSubscription<List<ConnectivityResult>> _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    getConnectivityType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getConnectivityType() async {
    late List<ConnectivityResult> connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return _updateState(connectivityResult);
  }

  _updateState(List<ConnectivityResult> result) {
// This condition is for demo purposes only to explain every connection type.
// Use conditions which work for your requirements.
    if (result.contains(ConnectivityResult.none)) {
      if (connectionType.value == 0) {
        connectionType.value = 0;
        // BotToast.closeAllLoading();
        AppSnackBar.openErrorSnackBar(message: 'No Internet Connection'.tr);
      }
      // No available network types
    }
    update();
    refresh();
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
