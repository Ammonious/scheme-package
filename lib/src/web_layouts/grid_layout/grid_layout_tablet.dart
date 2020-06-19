import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/web_layouts/decoration_view_model.dart';
import 'package:scheme_package/src/web_layouts/full_base_layout.dart';
import 'package:scheme_package/src/web_layouts/relative_height_base_layout.dart';
import 'package:scheme_theme/scheme_theme.dart';

import '../web_constants.dart';

class GridLayoutTablet extends StatelessWidget {
  final List<Widget> children;
  final List<Widget> decorations;
  final BaseLayoutType baseLayoutType;
  final Color backgroundColor;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final Alignment alignment;
  final double maxWidth;
  final LinearGradient gradient;
  final String backgroundImage;
  final EdgeInsets padding;
  GridLayoutTablet({
    Key key,
    this.baseLayoutType,
    this.backgroundColor = background,
    this.decorations,
                     this.crossAxisAlignment = CrossAxisAlignment.center,
                     this.mainAxisAlignment = MainAxisAlignment.spaceAround,
                     this.alignment = Alignment.topCenter,
    this.children,
    this.maxWidth,
    this.gradient,
    this.backgroundImage, this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (baseLayoutType) {
      case BaseLayoutType.Full:
        return fullLayout(context);
      case BaseLayoutType.Relative:
        return relativeLayout(context);
      default:
        return relativeLayout(context);
    }
  }

  fullLayout(BuildContext context) => FullBaseLayout(
        backgroundImage: backgroundImage,
        backgroundColor: backgroundColor,
        gradient: gradient,
        child: Container(
          padding: EdgeInsets.only(left: 24, right: 24),
          constraints: BoxConstraints(maxWidth: maxWidth ?? screenWidth),
          child: Stack(
            fit: StackFit.expand,
            children: gridChildren(
                context: context,
                maxWidth: maxWidth,
                decorations: decorations,
              padding: padding,
                children: children,
                crossAxisAlignment: crossAxisAlignment,
                mainAxisAlignment: mainAxisAlignment, ),
          ),
        ),
      );
  relativeLayout(BuildContext context) => RelativeBaseLayout(
        child: Container(
          padding: EdgeInsets.only(left: 24, right: 24),
          decoration: BoxDecoration(color: backgroundColor),
          child: Stack(
            alignment: alignment,
            fit: StackFit.expand,
            children: gridChildren(
                context: context,
                maxWidth: maxWidth,
              padding: padding,
                decorations: decorations,
                children: children,
                crossAxisAlignment: crossAxisAlignment,
                mainAxisAlignment: mainAxisAlignment, ),
          ),
        ),
      );
}
