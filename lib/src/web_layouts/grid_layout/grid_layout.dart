import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scheme_package/src/web_layouts/web_constants.dart';
import '../../../scheme_package.dart';
import 'grid_layout_mobile.dart';
import 'grid_layout_desktop.dart';
import 'grid_layout_tablet.dart';

class GridLayout extends StatelessWidget {
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
  GridLayout({
    Key key,
    @required this.baseLayoutType,
    this.backgroundColor = Colors.white,
    this.decorations,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.alignment = Alignment.topCenter,
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
    this.children,
    this.maxWidth,
    this.gradient,
    this.backgroundImage, this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayoutBuilder(
        portrait: (context) => mobile(),
        landscape: (context) => mobile(),
      ),
      tablet: OrientationLayoutBuilder(
        portrait: (context) => tablet(),
        landscape: (context) => desktop(),
      ),
      desktop: desktop(),
    );
  }

  mobile() {
    return GridLayoutMobile(
      children: children,
      decorations: decorations,
      baseLayoutType: baseLayoutType,
      backgroundColor: backgroundColor,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      alignment: alignment,
      padding: padding,
      gradient: gradient,
      maxWidth: maxWidth,
      backgroundImage: backgroundImage,
    );
  }

  tablet() {
    return GridLayoutTablet(
      children: children,
      decorations: decorations,
      baseLayoutType: baseLayoutType,
      backgroundColor: backgroundColor,
      crossAxisAlignment: crossAxisAlignment,
      padding: padding,
      mainAxisAlignment: mainAxisAlignment,
      alignment: alignment,
      gradient: gradient,
      maxWidth: maxWidth,
      backgroundImage: backgroundImage,
    );
  }

  desktop() {
    return GridLayoutDesktop(
      children: children,
      decorations: decorations,
      padding: padding,
      baseLayoutType: baseLayoutType,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      alignment: alignment,
      backgroundColor: backgroundColor,
      gradient: gradient,
      maxWidth: maxWidth,
      backgroundImage: backgroundImage,
    );
  }
}
