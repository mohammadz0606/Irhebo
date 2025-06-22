import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:irhebo/app/global_imports.dart';

class SocialAuthProvider extends ChangeNotifier {
  bool isLoadingGoogle = false;

  Future<void> googleAuth() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      log(googleAuth?.idToken ?? '');
      log(googleAuth?.accessToken ?? '');
    } catch (error) {
      AppSnackBar.openErrorSnackBar(message: error.toString());
      isLoadingGoogle = false;
      log(error.toString());
      notifyListeners();
    }
  }
}
