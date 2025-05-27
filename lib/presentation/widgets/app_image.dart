import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class AppImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double? radius;
  final Color? borderColor;
  final BoxFit? fit;
  const AppImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.radius,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: imageUrl,
        fit: fit ?? BoxFit.cover,
        placeholder: (context, url) => AppLoading(
          radius: radius ?? 0,
          width: width,
          height: height,
        ),
        errorWidget: (context, url, error) => Center(
            child: CachedNetworkImage(
          width: width,
          height: height,
          imageUrl: AppImages.userImageUrl6,
          fit: fit ?? BoxFit.cover,
        )),
        // errorWidget: (context, url, error) => Center(
        //     child: AppIcon(
        //   path: AppImages.steps,
        //   width: width,
        //   height: height,
        //   fit: fit ?? BoxFit.cover,
        //   // isSvg: true,
        // )),
      ),
    );
  }
}
