import 'package:flutter/material.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // for (int i = 0; i < controller.faqs.length; i++)
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 7.96 * (w / 100),
                  bottom: 2.48 * (w / 100),
                  right: 1.99 * (w / 100),
                  left: 1.99 * (w / 100)),
              child: Row(
                children: [
                  AppLoading(
                    width: 24.8 * (w / 100),
                    height: 24.8 * (w / 100),
                    radius: 100,
                  ),
                  SizedBox(
                    width: 2.98 * (w / 100),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLoading(
                        width: 25 * (w / 100),
                        height: 4 * (w / 100),
                        radius: 15,
                      ),
                      SizedBox(
                        height: 2 * (w / 100),
                      ),
                      AppLoading(
                        width: 15 * (w / 100),
                        height: 3 * (w / 100),
                        radius: 15,
                      ),
                      SizedBox(
                        height: 2 * (w / 100),
                      ),
                      AppLoading(
                        width: 15 * (w / 100),
                        height: 3 * (w / 100),
                        radius: 15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
                  child: AppLoading(
                    width: 100 * (w / 100),
                    height: 53.7 * (w / 100),
                    radius: 14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
                  child: AppLoading(
                    width: 100 * (w / 100),
                    height: 12.43 * (w / 100),
                    radius: 14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
                  child: AppLoading(
                    width: 100 * (w / 100),
                    height: 12.43 * (w / 100),
                    radius: 14,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
