import 'package:flutter/material.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class MediaItemShimmer extends StatelessWidget {
  const MediaItemShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < 4; i++)
            Row(
              children: [
                AppLoading(
                  width: 39.3 * (w / 100),
                  height: 50.24 * (w / 100),
                  radius: 25,
                ),
                SizedBox(
                  width: 3.98 * (w / 100),
                )
              ],
            )
        ],
      ),
    );
  }
}
