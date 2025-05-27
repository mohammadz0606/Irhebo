import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_wishlist_use_case.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/home_controller.dart';
import 'package:irhebo/presentation/screens/service_details/service_details_screen.dart';

class WishlistController extends GetxController {
  final appController = Get.find<AppController>();

  final RxBool _isLoading = false.obs;

  RxList<ServiceModel> _services = <ServiceModel>[].obs;

  // ignore: invalid_use_of_protected_member
  List<ServiceModel> get services => _services.value;
  bool get isLoading => _isLoading.value;

  set services(value) => _services.value = value;
  set isLoading(value) => _isLoading.value = value;

  @override
  onInit() async {
    super.onInit();
    if (appController.token.isNotEmpty) getServices();
  }

  receiveParameters() {}

  getServices() async {
    services.clear();
    isLoading = true;
    GetWishlistUseCase getWishlistUseCase = sl();
    final result = await getWishlistUseCase(());
    result!.fold((l) {
      isLoading = false;
    }, (r) {
      services = r.data;
      _services.refresh();
      isLoading = false;
    });
  }

  // onLikeService(int index) {
  //   services[index].isWishlist = !services[index].isWishlist!;
  //   _services.refresh();
  // }

  onTapService(int index) {
    Get.to(() => ServiceDetailsScreen(),
        arguments: {"id": services[index].id ?? 0});
  }

  onLikeService(int index) async {
    ServiceModel cachedService;
    cachedService = services.removeAt(index);
    _services.refresh();
    bool result = await appController.addToWishlist(cachedService.id);
    if (!result) {
      services.add(cachedService);
      _services.refresh();
    } else {
      Get.find<HomeController>().removeLikedService(cachedService.id!);
    }
  }
}
