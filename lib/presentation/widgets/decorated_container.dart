import 'package:flutter/material.dart';

class DecoratedContainer extends StatelessWidget {
  final Color? borderColor;
  final double? borderWidth;
  final Color? color;
  final bool center;
  final Widget? child;
  final double? radius;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;

  const DecoratedContainer(
      {super.key,
      this.borderColor,
      this.borderWidth,
      this.child,
      this.radius,
      this.color,
      this.width,
      this.height,
      this.center = true,
      this.onTap,
      this.margin,
      this.padding,
      this.gradient,
      this.boxShadow});

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : null,
      child: Container(
          clipBehavior: radius != 0 ? Clip.antiAliasWithSaveLayer : Clip.none,
          margin: margin,
          padding: padding,
          width: width,
          height: height,
          // padding: EdgeInsets.all(3.6*(w/100)),
          decoration: BoxDecoration(
              boxShadow: boxShadow,
              gradient: gradient,
              color: color ?? Colors.white,
              borderRadius: BorderRadius.circular(radius ?? 0),
              border: Border.all(
                  color: borderColor ?? Colors.transparent,
                  width: borderWidth ?? 1)),
          child: center ? Center(child: child) : child),
    );
  }
}

//        // borderRadius: BorderRadius.circular(radius ?? 0),
