import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/web_layouts/decoration_view_model.dart';
import 'package:scheme_package/src/web_layouts/full_base_layout.dart';
import 'package:scheme_package/src/web_layouts/relative_height_base_layout.dart';
import 'package:scheme_theme/scheme_theme.dart';

import '../web_constants.dart';

class GridLayoutDesktop extends StatelessWidget {
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
  GridLayoutDesktop({
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
    this.backgroundImage,
    this.padding,
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

  // ignore: slash_for_doc_comments
  /********************************
	 * ? Layout that Fills the entire height of the visible screen area.
	 *********************************/

  fullLayout(BuildContext context) => FullBaseLayout(
        backgroundImage: backgroundImage,
        backgroundColor: backgroundColor,
        gradient: gradient,
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth ?? screenWidth),
          child: Stack(
            alignment: alignment,
            children: gridChildren(
              padding: padding,
              decorations: decorations,
              children: children,
              maxWidth: maxWidth,
              context: context,
              crossAxisAlignment: crossAxisAlignment,
              mainAxisAlignment: mainAxisAlignment,
            ),
          ),
        ),
      );

  // ignore: slash_for_doc_comments
  /********************************
	 * ? Layout that has a size relative to it's contents.
	 *********************************/

  relativeLayout(BuildContext context) => RelativeBaseLayout(
        child: Container(
          decoration: gradient != null
              ? BoxDecoration(gradient: gradient)
              : BoxDecoration(color: backgroundColor),
          constraints:
              BoxConstraints(maxWidth: screenWidth),
          child: Stack(
            alignment: alignment,
            children: gridChildren(
              context: context,
              padding: padding,
              maxWidth: maxWidth,
              decorations: decorations,
              children: children,
              crossAxisAlignment: crossAxisAlignment,
              mainAxisAlignment: mainAxisAlignment,
            ),
          ),
        ),
      );
}
