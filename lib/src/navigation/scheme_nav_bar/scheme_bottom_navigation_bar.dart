import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/icons/flare_icon.dart';
import 'package:scheme_package/src/navigation/scheme_nav_bar/views/scheme_indicator.dart';
import 'package:scheme_package/src/navigation/scheme_nav_bar/views/scheme_indicator_view.dart';
import 'package:scheme_package/src/navigation/scheme_nav_bar/views/scheme_item_tile.dart';
import 'package:scheme_package/src/navigation/utils/selection_notifier.dart';

import 'bottom_nav_bar_utils.dart';
 
 
class SchemeBottomNavigationBar extends StatelessWidget {

  final List<NavBarItemData> items;


  final SchemeBarStyle schemeBarStyle;

  final double height;

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

  /// Whether the labels are shown for the selected [BottomNavigationBarItem].
  final bool showSelectedLabels;

  /// Whether the labels are shown for the selected [BottomNavigationBarItem].
  final bool showUnselectedLabels;

  /// The index into [items] for the current active [BottomNavigationBarItem].
  final int currentIndex;

  ///You can specify custom elevation shadow color
  final Color shadowColor;

  /// Defines the [SchemeShape] shape and behavior of a [SchemeBottomNavigationBar].
  ///
  /// See documentation for [SchemeShape] for information on the
  /// meaning of different shapes.
  ///
  /// Default is [SchemeIndicator.circle]
  final SchemeIndicator indicator;

  /// Defines the layout and behavior of a [SchemeBottomNavigationBar].
  ///
  /// See documentation for [FlareBarStyle] for information on the
  /// meaning of different styles.
  ///
  /// 

  /// You can define custom [ShapeBorder] with padding and elevation to [SchemeBottomNavigationBar]
  final ShapeBorder shape;
  final EdgeInsets padding;
  final double elevation;

  /// Called when one of the [items] is pressed.
  final ValueChanged<int> onPositionChanged;

  final SelectionNotifier _notifier;

  SchemeBottomNavigationBar({
    Color indicatorColor,
    Gradient indicatorGradient,
    Color backgroundColor,
    Gradient backgroundGradient,
    bool showSelectedLabels = false,
    this.showUnselectedLabels = false,
    this.items,
    this.currentIndex = 0,
    this.pinned = true,
    this.shape,
    this.padding = EdgeInsets.zero,
    this.elevation = 0,
    this.onPositionChanged, 
    this.indicator = SchemeIndicator.indicator,
    this.shadowColor = Colors.black, this.height, this.schemeBarStyle = SchemeBarStyle.flat,
  })  : assert((indicatorGradient == null && indicatorColor != null) ||
      (indicatorGradient != null && indicatorColor == null) ||
      (indicatorGradient == null && indicatorColor == null)),
        assert((backgroundColor == null && backgroundGradient != null) ||
            (backgroundColor != null && backgroundGradient == null) ||
            (backgroundColor == null && backgroundGradient == null)),
        this.backgroundGradient = backgroundGradient ??
            LinearGradient(colors: [
              backgroundColor ?? Colors.white,
              backgroundColor ?? Colors.white
            ]),
        selectedColor = indicatorGradient ??
            LinearGradient(colors: [
              indicatorColor ?? Colors.black,
              indicatorColor ?? Colors.black
            ]),
        _notifier = SelectionNotifier(currentIndex, onPositionChanged),
        showSelectedLabels =
        (indicator.type == SchemeIndicatorType.circle && showSelectedLabels)
            ? false
            : showSelectedLabels;

  @override
  Widget build(BuildContext context) {
    List<SchemeItemTile> tiles = barItems();

    return AnimatedPadding(
      padding: padding,
      duration: kThemeChangeDuration,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(
            left: false,
            right: false,
            child: Material(
              shadowColor: shadowColor,
              elevation: elevation,
              clipBehavior: Clip.antiAlias,
              shape: shape,
              child: Container(
                decoration: BoxDecoration(gradient: backgroundGradient),
                width: double.infinity,
                height: height ?? kBottomNavigationBarHeight,
                child: Stack(
                  children: [
                    SchemeIndicatorView(
                      itemsCount: items.length,
                      shape: indicator,
                      showSelectedLabels: showSelectedLabels,
                      showUnselectedLabels: showUnselectedLabels,
                      widgetEdgePadding: padding.left + padding.right,
                      snakeColor: selectedColor,
                      items: items,
                      notifier: _notifier,
                    ),
                    ClippedView(
                        child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: tiles)
                    )
                  ],
                ),
              ),
            ),
          ),
          AnimatedContainer(
            height: pinned
                ? MediaQuery.of(context).padding.bottom
                : 0,
            decoration: BoxDecoration(gradient: backgroundGradient),
            duration: kThemeChangeDuration,
          ),
        ],
      ),
    );
  }

  List<SchemeItemTile>  barItems() {
    switch(schemeBarStyle){
      case SchemeBarStyle.flat:
      case SchemeBarStyle.neu:
      case SchemeBarStyle.classic:
      case SchemeBarStyle.fading:
      case SchemeBarStyle.flare:
        return items
            .map((item) => SchemeItemTile.flare(
          flareIcon: item.flareIcon,
          itemData: item,
          selectedLabelVisible: showSelectedLabels,
          controller: FlareIconController(flareIcon:item.flareIcon,defaultScheme: item.selectedScheme),
          unselectedLabelVisible: showUnselectedLabels,
          index: items.indexOf(item),
          notifier: _notifier,
        ))
            .toList();
    }
    return  items
        .map((item) => SchemeItemTile.flare(
      flareIcon: item.flareIcon,
      itemData: item,
      controller: FlareIconController(flareIcon:item.flareIcon,
          defaultScheme: item.unSelectedScheme),
      selectedLabelVisible: showSelectedLabels,
      unselectedLabelVisible: showUnselectedLabels,
      index: items.indexOf(item),
      notifier: _notifier,
    ))
        .toList();
  }
}