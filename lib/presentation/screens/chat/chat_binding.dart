import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/chat/animation_button_controller.dart';
import 'package:irhebo/presentation/screens/chat/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
    Get.lazyPut(() => AnimationButtonController());
  }
}
