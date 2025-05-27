import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropdownItem extends StatelessWidget {
  final String label;

  const DropdownItem({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 3.48 * (w / 100),
        horizontal: 4.97 * (w / 100),
      ),
      child: Text(label),
    );
  }
}
