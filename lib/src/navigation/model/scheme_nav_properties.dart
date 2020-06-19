import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/navigation/model/nav_data.dart';
import 'package:scheme_theme/scheme_theme.dart';

class SchemeNavProperties {
  final IconThemeData unSelectedTheme;
  final IconThemeData selectedTheme;
  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;
  final double elevation;
  final Color backgroundColor;
  final NavSide navSide;
  final NavigationRailLabelType railLabelType;
  final RailAlignment railAlignment;
  final BarAlignment barAlignment;
  final bool extended;
  final double minWidth;
  final double minExtendedWidth;
  final SchemeBarStyle schemeBarStyle;
  final List<BoxShadow> boxShadow;
  final bool enableAnimation;
  final double height;
  final bool collapseOnScroll;
  final Gradient backgroundGradient;

  SchemeNavProperties({
    this.backgroundGradient,
    this.collapseOnScroll = false,
    this.schemeBarStyle = SchemeBarStyle.flat,
    this.boxShadow = bottomBarShadow,
    this.enableAnimation = false,
    this.height = kBottomNavigationBarHeight,
    this.unSelectedTheme = defaultIconTheme,
    this.selectedTheme = selectedIconTheme,
    this.selectedTextStyle,
    this.unSelectedTextStyle,
    this.railAlignment,
    this.extended,
    this.minWidth,
    this.backgroundColor = Colors.white,
    this.barAlignment = BarAlignment.center,
    this.navSide = NavSide.leading,
    this.elevation = 0,
    this.railLabelType = NavigationRailLabelType.selected,
    this.minExtendedWidth,
  });
}

class SchemeAppBarProperties {
  final bool collapseOnScroll;
  final Widget leading;
  final bool automaticallyImplyLeading;
  final Widget title;
  final List<Widget> actions;
  final Widget flexibleSpace;
  final PreferredSizeWidget bottom;
  final Brightness brightness;
  final IconThemeData iconTheme;
  final IconThemeData actionsIconTheme;
  final TextTheme textTheme;
  final bool primary;
  final bool centerTitle;
  final double titleSpacing;
  final ShapeBorder shape;
  final double bottomOpacity;
  final double toolbarOpacity;
  final SchemeBarStyle schemeBarStyle;
  final LinearGradient backgroundGradient;
  final Color backgroundColor;
  final double elevation;

  SchemeAppBarProperties({this.backgroundGradient,this.backgroundColor,this.elevation = 0,
    this.collapseOnScroll = false,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.shape,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0, this.schemeBarStyle,});
}

enum RailAlignment { top, bottom, center }

enum BarAlignment { start, end, center }
