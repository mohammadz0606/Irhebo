// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class PortfolioShimmer extends StatelessWidget {
  const PortfolioShimmer({
    super.key,
    this.forClint = true,
  });

  final bool forClint;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    if (forClint) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 3.98 * (w / 100), vertical: 2.48 * (w / 100)),
        child: MasonryGridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisSpacing: 3.48 * (w / 100),
          mainAxisSpacing: 3.48 * (w / 100),
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
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
    } else {
     return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2 * (w / 100),
          vertical: 3 * (w / 100),
        ),
        child: SizedBox(
          height: 47 * (w / 100),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            separatorBuilder: (_, __) => SizedBox(width: 3.48 * (w / 100)),
            itemBuilder: (context, index) {
              return Container(
                width: 44.27 * (w / 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  color: Colors.transparent,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: AppLoading(
                        radius: 18,
                        width: 44.27 * (w / 100),
                        height: 74.12 * (w / 100),
                      ),
                    ),
                    const Positioned(
                      top: 10,
                      left: 10,
                      child: AppLoading(
                        width: 30,
                        height: 30,
                        radius: 15,
                      ),
                    ),
                    const Positioned(
                      top: 10,
                      right: 10,
                      child: AppLoading(
                        width: 30,
                        height: 30,
                        radius: 15,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
