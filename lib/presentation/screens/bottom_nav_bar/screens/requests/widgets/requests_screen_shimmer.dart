import 'package:flutter/material.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class RequestsScreenShimmer extends StatelessWidget {
  const RequestsScreenShimmer({super.key, r});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1 * (w / 100)),
            child: Row(
              children: [
                for (int i = 0; i < 4; i++)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 1.24 * (w / 100),
                      vertical: 0.49 * (w / 100),
                    ),
                    child: AppLoading(
                      width: 30 * (w / 100),
                      height: 9.2 * (w / 100),
                      radius: 50,
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.22 * (w / 100),
        ),
        Column(
          children: [
            for (int i = 0; i < 7; i++)
              Padding(
                padding: EdgeInsets.only(
                    right: 3.98 * (w / 100),
                    left: 3.98 * (w / 100),
                    bottom: 2.73 * (w / 100)),
                child: AppLoading(
                  width: 92.1 * (w / 100),
                  height: 39.8 * (w / 100),
                  radius: 27,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
