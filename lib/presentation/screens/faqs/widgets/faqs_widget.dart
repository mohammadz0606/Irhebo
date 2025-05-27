import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/domain/models/faq_model.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/video_play_widget.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

class FaqsWidget extends StatelessWidget {
  final FaqModel faqs;
  final bool isVisible;
  final Function() onTapClose;
  final Function() onTapOpen;
  const FaqsWidget(
      {super.key,
      required this.faqs,
      required this.onTapClose,
      required this.isVisible,
      required this.onTapOpen});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 4.97 * (w / 100)),
      padding: EdgeInsets.symmetric(vertical: 3.98 * (w / 100)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => onTapOpen(),
                  child: Text(
                    faqs.question ?? "",
                    style: Get.theme.textTheme.bodyLarge!.copyWith(
                        color: Get.find<AppController>().darkMode
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              InkWell(
                onTap: () => onTapClose(),
                child: AppIcon(
                  path: isVisible ? AppIcons.collapse : AppIcons.expand,
                  color: Get.find<AppController>().darkMode
                      ? Colors.white
                      : Colors.black,
                  width: 5.97 * (w / 100),
                  height: 5.97 * (w / 100),
                ),
              )
            ],
          ),
          Visibility(
            visible: isVisible,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.98 * (w / 100),
                    ),
                    Container(
                      // color: Colors.green,
                      child: HtmlWidget(
                        faqs.answer ?? "",
                        textStyle: Get.theme.textTheme.bodyMedium!.copyWith(
                          color: Get.find<AppController>().darkMode
                              ? Colors.white.withOpacity(0.85)
                              : Colors.black.withOpacity(0.85),
                        ),
                      ),
                    ),
                  ],
                ),
                if (faqs.mediaPath != null) ...[
                  Container(
                    // color: Colors.red,
                    height: 4.47 * (w / 100),
                  ),
                  faqs.mediaType != "image"
                      ? VideoMediaWidget(mediaUrl: faqs.mediaPath ?? "")
                      : AppImage(
                          imageUrl: faqs.mediaPath ?? "",
                          width: 88 * (w / 100),
                          // height: 46.7 * (w / 100),
                          radius: 8,
                        ),
                  Container(
                    // color: Colors.amber,
                    height: 4.47 * (w / 100),
                  )
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
