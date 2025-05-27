import 'package:flutter/material.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/video_play_widget.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

class MediaSection extends StatelessWidget {
  final List<MediaModel> mediaList;
  final Function(int i)? onTapServices;

  const MediaSection({
    super.key,
    required this.mediaList,
    this.onTapServices,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < mediaList.length; i++)
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => onTapServices!(i),
                      child: mediaList[i].mediaType != "image"
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: VideoMediaWidget(
                                  mediaUrl: mediaList[i].mediaPath ?? ""),
                            )
                          : AppImage(
                              imageUrl: mediaList[i].mediaPath ?? "",
                              width: 39.3 * (w / 100),
                              height: 50.24 * (w / 100),
                              radius: 25,
                            ),
                    ),
                    SizedBox(
                      width: 3.98 * (w / 100),
                    )
                  ],
                )
            ],
          ),
        ),
        SizedBox(
          height: 6.21 * (w / 100),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }
}
