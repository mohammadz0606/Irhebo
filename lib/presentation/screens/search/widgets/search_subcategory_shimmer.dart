// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class SearchSubcategoryShimmer extends StatelessWidget {
  const SearchSubcategoryShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.98 * (w / 100)),
      child: Column(
        children: [
          for (int i = 0; i < 9; i++)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.99 * (w / 100)),
              child: AppLoading(
                radius: 20,
                height: 16.9 * (w / 100),
                width: 100 * (w / 100),
              ),
            )
        ],
      ),
    );
  }
}
