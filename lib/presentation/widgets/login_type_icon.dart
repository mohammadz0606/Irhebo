import 'package:flutter/material.dart';

import 'app_icon.dart';

class LoginTypeIcon extends StatelessWidget {
  final String icon;
  final Function onTap;

  const LoginTypeIcon({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(3.73 * (w / 100)),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFF9E1926).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 6))
            ]),
        child: AppIcon(path: icon, isSvg: true),
      ),
    );
  }
}
