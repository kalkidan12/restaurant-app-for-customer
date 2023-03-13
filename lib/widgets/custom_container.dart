import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomContainer extends StatelessWidget {
  double? width;
  double? height;
  BorderRadiusGeometry? borderRadius;

  EdgeInsetsGeometry? padding;
  Decoration? decoration;
  Widget? child;
  BoxBorder? border;
  Color? color;
  DecorationImage? image;
  List<BoxShadow>? boxShadow;
  AlignmentGeometry? alignment;

  CustomContainer(
      {super.key,
      this.width,
      this.height,
      this.padding,
      this.decoration,
      this.child,
      this.border,
      this.color,
      this.image,
      this.boxShadow,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      alignment: alignment,
      width: width,
      height: height,
      child: child,
      decoration: BoxDecoration(
          color: color,
          image: image,
          boxShadow: boxShadow,
          border: border,
          borderRadius: borderRadius),
    );
  }
}
