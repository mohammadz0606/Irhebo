import 'package:flutter/material.dart';
import 'package:irhebo/presentation/widgets/bottom_sheet_header.dart';

class AppBottomSheet extends StatelessWidget {
  final Widget child;
  final String? title;
  const AppBottomSheet({super.key, required this.child, this.title});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.97 * (w / 100),
        vertical: 3.98 * (w / 100),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(
            title: title,
          ),
          child,
        ],
      ),
    );
  }
}
