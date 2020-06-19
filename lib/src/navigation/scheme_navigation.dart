import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/hooks/scroll_nav_controller_hook.dart';
import 'package:scheme_package/src/navigation/model/scheme_nav_properties.dart';
import 'package:scheme_package/src/navigation/scheme_nav_bar/scheme_bottom_navigation_bar.dart';
import 'package:scheme_package/src/navigation/scheme_rail.dart';
import 'package:scheme_package/src/navigation/utils/nav_bar_controller.dart';

import 'model/nav_data.dart';
import 'scheme_nav_bar/views/scheme_indicator.dart';

class SchemeNavigation extends HookWidget {
  final SchemeNavProperties properties;
  final SchemeNavigationType navigationType;
  final List<NavBarItemData> navigationItems;
  final Function(int index) onDestinationSelected;

  final double height;
  final Color backgroundColor;
  final Color indicatorColor;
  final double elevation;
  final EdgeInsets padding;

  /// Called when one of the [items] is pressed.
  final ValueChanged<int> onPositionChanged;

  /// You can define custom [ShapeBorder] with padding and elevation to [SchemeNavigation.bottom]
  final ShapeBorder shape;

  /// For [SchemeAppBar] this is the leading [Widget]
  ///
  /// Defines the [SchemeShape] shape and behavior of a [SchemeNavigation.bottom].
  ///
  /// See documentation for [SchemeShape] for information on the
  /// meaning of different shapes.
  ///
  /// Default is [SchemeIndicator.indicator]
  final SchemeIndicator indicator;

  /// Whether the labels are shown for the selected [BottomNavigationBarItem].
  final bool showSelectedLabels;

  /// Whether the labels are shown for the selected [BottomNavigationBarItem].
  final bool showUnselectedLabels;

  /// use [floating] style if you want to
  /// separate [SchemeBottomNavigationBar] from bottom side
  /// Default is [pinned]
  /// [pinned] is default [SchemeBottomNavigationBar] style
  /// which is pinned to bottom side
  final bool pinned;

  /// If [FlareBarStyle.floating] this color is
  /// used as background color of shaped view.
  /// If [FlareBarStyle.pinned] this color just
  /// a background color of whole [SchemeBottomNavigationBar] view
  final Gradient backgroundGradient;

  /// This color represents a SnakeView and unselected
  /// Icon and label color
  final Gradient selectedColor;
  
  final Gradient indicatorGradient;

  final Widget header;
  final Widget footer;
  final int selectedIndex;
  final NavBarScrollController appBarController;
  final SchemeBarStyle schemeBarStyle;

  SchemeNavigation._internal(
      {Key key,
        this.indicatorGradient,
        this.navigationType,
      this.schemeBarStyle = SchemeBarStyle.flat,
      this.navigationItems,
      this.appBarController,
      this.header,
      this.footer,
      this.properties,
      this.onDestinationSelected,
      this.height,
      this.backgroundColor,
      this.indicatorColor,
      this.elevation,
      this.padding,
      this.onPositionChanged,
      this.shape,
      this.indicator,
      this.showSelectedLabels,
      this.showUnselectedLabels,
      this.pinned,
      this.backgroundGradient,
      this.selectedColor,
      this.selectedIndex})
      : super(key: key);

  factory SchemeNavigation.bottom(
      {List<NavBarItemData> navigationItems,
      SchemeBarStyle schemeBarStyle,
        int selectedIndex = 0,
        Color backgroundColor,
        Color indicatorColor,
        Gradient indicatorGradient, 
        Gradient backgroundGradient,
        bool showSelectedLabels = false,
        bool showUnselectedLabels = false,
        SchemeIndicator indicator = SchemeIndicator.indicator,
        bool pinned = true,
        ShapeBorder shape,
        EdgeInsets padding = EdgeInsets.zero,
        double elevation = 0.0,
        double height,
        ValueChanged<int> onPositionChanged,}) {
    return SchemeNavigation._internal(
      navigationType: SchemeNavigationType.bottom,
      navigationItems: navigationItems,
      schemeBarStyle: schemeBarStyle,
      selectedIndex: selectedIndex,
      backgroundColor: backgroundColor,
      indicatorColor: indicatorColor,
      backgroundGradient: backgroundGradient,
      indicator: indicator,
      indicatorGradient: indicatorGradient,
      padding: padding,
      pinned: pinned,
      shape: shape,
      elevation: elevation,
      showUnselectedLabels: showUnselectedLabels,
      showSelectedLabels: showSelectedLabels,
      onPositionChanged: (index) => onPositionChanged(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scrollNavigationController = appBarController ??
        useNavController(
            navigationType: navigationType, onTap: (index) => onTap(index));
    return Material(
      color: Colors.transparent,
      child: initNavigation(scrollNavigationController),
    );
  }

  initNavigation(NavBarScrollController controller) {
    switch (navigationType) {
      case SchemeNavigationType.drawer:
        break;
      case SchemeNavigationType.top:
      case SchemeNavigationType.bottom:
        return SchemeBottomNavigationBar(
          schemeBarStyle: schemeBarStyle,
          height: height,
          padding: padding,
          backgroundColor: backgroundColor,
          backgroundGradient: backgroundGradient,
          shape: shape,
          elevation: elevation,
          pinned: pinned,
          indicator: indicator,
          indicatorColor: indicatorColor,
          indicatorGradient: indicatorGradient,
          showUnselectedLabels: showUnselectedLabels,
          showSelectedLabels: showSelectedLabels,
          items: navigationItems,
          currentIndex: 0,
          onPositionChanged: (index) => onPositionChanged(index),
        );
      case SchemeNavigationType.rail:
        return StreamBuilder<int>(
            initialData: 0,
            stream: controller.pageStream,
            builder: (context, currentIndex) {
              return SchemeNavRail(
                header: header,
                footer: footer,
                properties: properties,
                items: navigationItems,
                onDestinationSelected: (index) => onDestinationSelected(index),
                selectedIndex: selectedIndex ??
                    (currentIndex != null && currentIndex.hasData
                        ? currentIndex.data
                        : 0),
              );
            });
    }
  }

  void onTap(int index) {
    print("Tapped on $index");
  }
}
