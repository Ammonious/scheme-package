import 'package:flutter/material.dart';

import '../../scheme_package.dart';
import 'decoration_view_model.dart';
import 'package:scheme_theme/scheme_theme.dart';

enum BaseLayoutType { Full, Relative }

enum LayoutPosition { Left, Right, Top, Bottom }

gridChildren(
    {BuildContext context,
    List<Widget> decorations,
    List<Widget> children,EdgeInsets padding,
    CrossAxisAlignment crossAxisAlignment,
    MainAxisAlignment mainAxisAlignment,
    double maxWidth}) {
  List<Widget> items = List();
  if (decorations != null) {
    decorations.forEach((element) {
      items.add(element);
    });
  }
  if (children != null)
    items.add(Container(
      padding: padding ?? EdgeInsets.only(left: 24,right: 24),
      width: maxWidth ?? screenWidth,
      constraints: BoxConstraints(maxWidth: maxWidth ?? screenWidth),
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: MainAxisSize.max,
        children: children,
      ),
    ));
  else
    items.add(Container());

  return items;
}
