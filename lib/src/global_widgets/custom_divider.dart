import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double width;
  final Color color;
  final double horizontalPadding;
  final double verticalPadding;
  final bool isVertical;
  final double height;
  const CustomDivider({
    Key key,
    this.width = 2,
    this.color, this.horizontalPadding = 24, this.verticalPadding = 8, this.isVertical = false, this.height = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: horizontalPadding, right: horizontalPadding, top: verticalPadding, bottom: verticalPadding),
      child: isVertical ? verticalDivide : horizontalDivide,);
  }

  get horizontalDivide{
    return Container(
      height: width,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.withOpacity(0.25),
        borderRadius: BorderRadius.all(Radius.circular(width / 2)),
      ),
    );
  }

  get verticalDivide{
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.withOpacity(0.25),
        borderRadius: BorderRadius.all(Radius.circular(width / 2)),
      ),
    );
  }
}