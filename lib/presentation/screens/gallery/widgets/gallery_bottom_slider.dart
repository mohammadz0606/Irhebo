import 'package:flutter/material.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/video_play_widget.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

class GalleryBottomSlider extends StatelessWidget {
  final List<MediaModel> media;
  final ScrollController scrollController;
  final int pageIndex;
  final Function(int) onTapSliderImage;
  const GalleryBottomSlider(
      {super.key,
      required this.media,
      required this.pageIndex,
      required this.onTapSliderImage,
      required this.scrollController});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Center(
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < media.length; i++)
              Padding(
                padding: pageIndex == i
                    ? EdgeInsets.symmetric(horizontal: 5 * (w / 100))
                    : EdgeInsets.zero,
                child: GestureDetector(
                  onTap: () => onTapSliderImage(i),
                  child: media[i].mediaType != "image"
                      ? VideoMediaWidget(mediaUrl: media[i].mediaPath ?? "")
                      : AppImage(
                          imageUrl: media[i].mediaPath ?? "",
                          width: 10 * (w / 100),
                          height: 10 * (w / 100),
                          fit: BoxFit.cover,
                        ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
