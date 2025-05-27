import 'package:flutter/material.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class PortfolioDetailsShimmer extends StatelessWidget {
  const PortfolioDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < 3; i++)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1 * (w / 100)),
                child: AppLoading(
                  height: 4 * (w / 100),
                  width: i == 0 || i == 1 ? 85 * (w / 100) : 60.16 * (w / 100),
                  radius: 5,
                ),
              ),
            SizedBox(
              height: 3 * (w / 100),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < 4; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLoading(
                        height: 105 * (w / 100),
                        width: 100 * (w / 100),
                        radius: 8,
                      ),
                      SizedBox(
                        height: 4.97 * (w / 100),
                      ),
                    ],
                  )
              ],
            )
          ],
        )
      ],
    );
  }
}
