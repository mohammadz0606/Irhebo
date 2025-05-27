// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class StepsPageViewShimmer extends StatelessWidget {
  const StepsPageViewShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Expanded(
      child: SizedBox(
        width: 100 * (w / 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppLoading(
              width: 71.39 * (w / 100),
              height: 71.39 * (w / 100),
              radius: 40,
            ),
            SizedBox(
              height: 7.71 * (w / 100),
            ),
            AppLoading(
              width: 65.39 * (w / 100),
              height: 5 * (w / 100),
              radius: 40,
            ),
            SizedBox(
              height: 3.73 * (w / 100),
            ),
            AppLoading(
              width: 68 * (w / 100),
              height: 4 * (w / 100),
              radius: 40,
            ),
          ],
        ),
      ),
    );
  }
}
