import 'package:flutter/cupertino.dart';
import 'package:irhebo/domain/providers/calls.dart';
import 'package:irhebo/domain/providers/chat/chat_provider.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

import '../../../app/calls/agora_configuration.dart';
import '../../../app/global_imports.dart';
import '../../../app/resources/images.dart';
import '../../widgets/gradient_icon.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Consumer2<CallsProvider, ChatProvider>(
      builder: (context, provider, chatProvider, _) {
        return WillPopScope(
          onWillPop: () => onEndCall(),
          child: Scaffold(
            appBar: AppBar(
              leadingWidth: 14 * (w / 100),
              leading: Row(
                children: [
                  SizedBox(
                    width: 3.98 * (w / 100),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50 * (w / 100)),
                    onTap: () => onEndCall(),
                    child: const GradientIcon(
                      icn: AppIcons.arrowLeft,
                      matchTextDirection: true,
                    ),
                  ),
                ],
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 50,
                children: [
                  AppImage(
                    imageUrl: chatProvider.appbarData?.avatar ??
                        AppImages.placeholder,
                    fit: BoxFit.cover,
                    radius: 20.r,
                    height: 200,
                  ),
                  AppButton(
                    backGroundColor: AppLightColors.red,
                    child: Row(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          CupertinoIcons.phone_down_fill,
                          size: 40,
                        ),
                        Text(
                          'End Call'.tr,
                          style: Get.theme.textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      await onEndCall();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> onEndCall() async {
    Get.back();
    await Provider.of<CallsProvider>(Get.context!, listen: false).endCall();
    await AgoraConfiguration().leaveCall();
    return true;
  }
}
