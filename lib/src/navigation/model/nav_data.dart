import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../scheme_package.dart';

enum SchemeBarStyle { flat, neu, classic, fading, flare }

enum NavSide { leading, trailing }

enum SchemeNavigationType { drawer, top, bottom, rail }

class NavBarItemData {
  /// Title of the button. Must not be null if using [SchemeNavRail].
  final String title;

  /// [SchemeNavRail] - child replaces the [title]. Can be used to show a [Column] with title and subtitle.
  final Widget label;

  /// Optional [TextStyle] for [Navigation] title.
  final TextStyle textStyle;

  /// [Icon] for the given button
  final Widget icon;

  /// [IconData] iconData for the given item. Must not be null if using [SchemeNavRail].
  final IconData iconData;

  /// [IconData] selectedIcon for the given item. Must not be null if using [SchemeNavRail].
  final IconData selectedIconData;

  final double iconSize;

  final Color unSelectedColor;

  /// Selected [Color] of the button
  final Color selectedColor;

  /// This is specific to [BottomNavigation] button width.
  final double width;

  /// [Deprecated] old method for navigation. Use [route].
  final Widget child;

  /// Optionally use route name for [Route] navigation.
  final String route;

  final String flareIcon;

  final ColorScheme selectedScheme;

  final ColorScheme unSelectedScheme;


  NavBarItemData(
      {@required this.title, 
      this.icon,
      this.flareIcon,
      this.width = 110,
      this.selectedColor,
      this.label,
      this.selectedIconData,
      this.iconData,
      this.child,
      this.route,
      this.textStyle,
      this.selectedScheme,
      this.unSelectedScheme,
      this.iconSize = 24,
      this.unSelectedColor,
      });

  factory NavBarItemData.flare(
      {String flareIcon,
      double iconSize = 24,
        double width = 110,
      String title,
      String route,
      Widget label,
      ColorScheme selectedScheme,
        ColorScheme unSelectedScheme,
      TextStyle textStyle}) {
    return NavBarItemData(
        flareIcon: flareIcon,
        iconSize: iconSize,
        width: width,
        title: title,
        route: route,
        textStyle: textStyle,
        label: label,
        unSelectedScheme: unSelectedScheme,
        selectedScheme: selectedScheme,);
  }
}
