import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:scheme_theme/scheme_theme.dart';
class BubbleDivisionStyle extends StatelessWidget {
  final Color color;
  final double size;
  final double scale;
  final GradientType gradientType;
  BubbleDivisionStyle(
      {Key key, this.color = Colors.blue, this.size = 350, this.scale = 1.0, this.gradientType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Parent(child: bubble, style: setStyle(style(size, scale)));
  }

  get bubble => Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: color.shade700, offset: Offset(4.0, 4.0), blurRadius: 10.0)
            ]),
      );




  final style = (double size, double scale) => ParentStyle()
    ..height(size)
    ..width(size)
    ..circle(true)
    ..scale(scale)
    ..animate(350, Curves.fastOutSlowIn);



  setStyle(ParentStyle style) {
    switch (gradientType) {
      case GradientType.radial:
        // TODO: Handle this case.
        return style.clone()
          ..radialGradient(radius: size, colors: [color.shade500, color.shade700]);
      case GradientType.linear:
        // TODO: Handle this case.
        return style.clone()
          ..linearGradient(
              colors: [color.shade500, color.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight);
      case GradientType.sweep:
        // TODO: Handle this case.
        return style.clone()
          ..linearGradient(
              colors: [color.shade500, color.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight);
    }
  }
}
