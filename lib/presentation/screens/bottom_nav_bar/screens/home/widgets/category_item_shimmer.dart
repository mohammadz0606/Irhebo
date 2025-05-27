// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class CategoryItemShimmer extends StatelessWidget {
  final bool home;
  const CategoryItemShimmer({
    super.key,
    this.home = true,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: home ? 2.73 * (w / 100) : 0,
          vertical: home ? 2.48 * (w / 100) : 0),
      child: Column(
        children: [
          AppLoading(
            width: 16.16 * (w / 100),
            height: 16.16 * (w / 100),
            radius: 50 * (w / 100),
          ),
          SizedBox(
            height: 2.48 * (w / 100),
          ),
          Column(
            children: [
              AppLoading(
                height: 2.5 * (w / 100),
                width: 16.16 * (w / 100),
                radius: 5,
              ),
              SizedBox(
                height: 1 * (w / 100),
              ),
              AppLoading(
                height: 2.5 * (w / 100),
                width: 9.16 * (w / 100),
                radius: 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}
