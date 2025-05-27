import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/gallery/gallery_controller.dart';

class GalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GalleryController());
  }
}
