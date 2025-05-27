// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class PortfolioShimmer extends StatelessWidget {
  const PortfolioShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 3.98 * (w / 100), vertical: 2.48 * (w / 100)),
      child: MasonryGridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisSpacing: 3.48 * (w / 100),
        mainAxisSpacing: 3.48 * (w / 100),
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Fixed number of columns
        ),
        itemCount: 7,
        itemBuilder: (context, index) {
          return AppLoading(
            radius: 18,
            width: 44.27 * (w / 100),
            height: (index % 2 != 0) || (index == 6)
                ? 35.32 * (w / 100)
                : 74.12 * (w / 100),
          );
        },
      ),
    );
  }
}
