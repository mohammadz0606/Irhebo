import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/portfolio_details/portfolio_details_controller.dart';

class PortfolioDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PortfolioDetailsController());
  }
}
