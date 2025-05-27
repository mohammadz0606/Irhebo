import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/search/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}
