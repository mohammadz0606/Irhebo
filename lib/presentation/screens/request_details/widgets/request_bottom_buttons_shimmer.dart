import 'package:flutter/material.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class RequestBottomButtonsShimmer extends StatelessWidget {
  const RequestBottomButtonsShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.97 * (w / 100)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 4 * (w / 100),
          ),
          AppLoading(
            height: 13.18 * (w / 100),
            width: w,
            radius: 50,
          ),
          SizedBox(
            height: 2 * (w / 100),
          ),
          AppLoading(
            height: 13.18 * (w / 100),
            width: w,
            radius: 50,
          ),
          SizedBox(
            height: 4 * (w / 100),
          ),
        ],
      ),
    );
  }
}
