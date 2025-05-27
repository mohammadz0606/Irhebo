import 'package:flutter/material.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class FaqsShimmer extends StatelessWidget {
  const FaqsShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        for (int i = 0; i < 11; i++)
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 3.98 * (w / 100), vertical: 1.99 * (w / 100)),
                padding: EdgeInsets.symmetric(horizontal: 3.98 * (w / 100)),
                child: AppLoading(
                  width: 90 * (w / 100),
                  height: 13.9 * (w / 100),
                  radius: 8,
                ),
              ),
            ],
          )
      ],
    );
  }
}
