import 'package:flutter/material.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/video_play_widget.dart';

import 'package:irhebo/presentation/widgets/app_image.dart';

class GalleryContent extends StatelessWidget {
  final List<MediaModel> media;
  final PageController? pageController;
  final Function(int) onPageChanged;

  const GalleryContent({
    super.key,
    required this.media,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Expanded(
      child: PageView(
        onPageChanged: onPageChanged,
        controller: pageController,
        children: [
          for (int i = 0; i < media.length; i++)
            media[i].mediaType != "image"
                ? VideoMediaWidget(mediaUrl: media[i].mediaPath ?? "")
                : AppImage(
                    imageUrl: media[i].mediaPath ?? "",
                    fit: BoxFit.contain,
                  )
        ],
      ),
    );
  }
}
