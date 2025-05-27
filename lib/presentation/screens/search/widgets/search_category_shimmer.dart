// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/category_item_shimmer.dart';

class SearchCategoryShimmer extends StatelessWidget {
  const SearchCategoryShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Wrap(
      runSpacing: 11.9 * (w / 100),
      spacing: 7.46 * (w / 100),
      children: [
        for (int i = 0; i < 12; i++)
          CategoryItemShimmer(
            home: false,
          )
      ],
    );
  }
}
