import 'package:irhebo/app/global_imports.dart';

class FreelancerServiceParam {
  //final int userId;
  final int? page;
  final int? prePage;

  FreelancerServiceParam({
    //required this.userId,
    this.page,
    this.prePage,
  });

  Map<String, dynamic> toJson() {
    AppPreferences prefs = sl();
    return {
      "user_id": prefs.getInt(key: AppPrefsKeys.USER_ID),
      "page": page,
      "per_page": prePage,
    };
  }
}
