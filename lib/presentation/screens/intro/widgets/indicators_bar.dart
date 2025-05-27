// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:irhebo/presentation/screens/intro/widgets/indicator_item.dart';

class IndicatorsBar extends StatelessWidget {
  final int pageIndex;
  final int length;
  const IndicatorsBar(
      {super.key, required this.pageIndex, required this.length});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        for (int i = 0; i < length; i++)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.74 * (w / 100)),
            child: IndicatorItem(
              selected: i == pageIndex,
            ),
          )
      ],
    );
  }
}
