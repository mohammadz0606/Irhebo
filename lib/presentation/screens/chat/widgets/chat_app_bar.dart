
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/domain/providers/calls.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';
import 'package:irhebo/presentation/widgets/gradient_icon.dart';

import '../../../../app/global_imports.dart';
import '../../../widgets/app_image.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? imageUrl;
  final bool showSearch;
  final ChatType type;
  final Function() onTapSearch;
  final int receiverId;

  // final Function()? onTapBack;
  const ChatAppBar({
    super.key,
    required this.title,
    required this.type,
    required this.onTapSearch,
    required this.showSearch,
    this.imageUrl,
    required this.receiverId,
    // this.onTapBack,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        AppBar(
          leadingWidth: 14 * (w / 100),
          leading: Row(
            children: [
              SizedBox(
                width: 3.98 * (w / 100),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(50 * (w / 100)),
                onTap: () => Get.back(),
                child: const GradientIcon(
                  icn: AppIcons.arrowLeft,
                  matchTextDirection: true,
                ),
              ),
            ],
          ),
          title: Row(
            children: [
              if (imageUrl != null)
                //imageUrl
                AppImage(
                  imageUrl: imageUrl ?? AppImages.placeholder,
                  height: 6.96 * (w / 100),
                  width: 6.96 * (w / 100),
                  radius: 50 * (w / 100),
                )
              else
                AppIcon(
                  path: AppImages.bot,
                  height: 6.96 * (w / 100),
                  width: 6.96 * (w / 100),
                  isSvg: false,
                ),
              SizedBox(
                width: 2 * (w / 100),
              ),
              Text(
                type == ChatType.Bot ? "My Bot" : title,
                style: Get.theme.textTheme.titleSmall!.copyWith(
                  color: Get.find<AppController>().darkMode
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          actions: type == ChatType.Bot
              ? []
              : [
                  Consumer<CallsProvider>(
                    builder: (context, provider, child) {
                      return Visibility(
                        visible: !provider.isLoadingStartCall,
                        replacement: const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        child: InkWell(
                          onTap: () async {
                            await provider.startCall(receiverId: receiverId);
                          },
                          borderRadius: BorderRadius.circular(50 * (w / 100)),
                          child: const GradientIcon(
                            icn: AppIcons.call,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 2.48 * (w / 100),
                  ),
                  // InkWell(
                  //   onTap: () => onTapSearch(),
                  //   borderRadius: BorderRadius.circular(50 * (w / 100)),
                  //   child: const GradientIcon(
                  //     icn: AppIcons.searchIcon,
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 3.92 * (w / 100),
                  // ),
                ],
        ),
        // if (showSearch)
        //   AppTextField(
        //     controller: TextEditingController(),
        //     hint: "Search here",
        //     isSearch: true,
        //     isChat: true,
        //   ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
