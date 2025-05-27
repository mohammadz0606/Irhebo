import 'package:flutter/material.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class DescriptionShimmer extends StatelessWidget {
  const DescriptionShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 4.97 * (w / 100),
        ),
        AppLoading(height: 5 * (w / 100), width: 20 * (w / 100), radius: 8),
        Container(
          width: w,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.23 * (w / 100)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < 3; i++)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1 * (w / 100)),
                      child: AppLoading(
                        height: 3 * (w / 100),
                        width: i == 0
                            ? 90 * (w / 100)
                            : i == 1
                                ? 85 * (w / 100)
                                : 70 * (w / 100),
                        radius: 5,
                      ),
                    ),
                ],
              )),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
          child: Divider(
            height: 1,
          ),
        ),
      ],
    );
  }
}
