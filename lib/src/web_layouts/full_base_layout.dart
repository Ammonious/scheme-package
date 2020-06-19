import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_theme/scheme_theme.dart';

class FullBaseLayout extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final LinearGradient gradient;
  final String backgroundImage;
  FullBaseLayout(
      {Key key, this.child, this.backgroundColor = background, this.gradient, this.backgroundImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: screenHeight,

        decoration: gradient != null
            ? gradientDecoration
            : backgroundImage != null ? imageDecoration : colorDecoration,
        child: child,
      ),
    );
  }

  get gradientDecoration => BoxDecoration(gradient: gradient);


  get colorDecoration => BoxDecoration(
        color: backgroundColor,
      );


  get imageDecoration => BoxDecoration(
      color: backgroundColor,
      image: DecorationImage(image: AssetImage(backgroundImage), fit: BoxFit.cover));
}
