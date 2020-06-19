import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/navigation/model/nav_data.dart';
import 'package:scheme_package/src/navigation/model/scheme_nav_properties.dart';
import 'package:scheme_package/src/navigation/scheme_app_bar/fading_app_bar.dart';
import 'package:scheme_package/src/navigation/scheme_nav_bar/navigation_items/neu_navigation_item.dart';
import 'package:scheme_package/src/navigation/scheme_nav_bar/views/scheme_indicator.dart';
import 'package:scheme_package/src/navigation/utils/nav_bar_controller.dart';
import 'package:scheme_theme/scheme_theme.dart';

import 'bottom_nav_bar_utils.dart';
import 'navigation_items/flip_navigation_item.dart';

class SchemeNavigationBar extends HookWidget {
  final Function(int index) onDestinationSelected;
  final List<NavBarItemData> items;
  final SchemeBarStyle navBarStyle;
  final SchemeNavigationType navigationType;
  final bool enableAnimation;
  final bool enableIconAnimation;
  final SchemeNavProperties properties;
  final bool collapseOnScroll;
  final NavBarScrollController scrollNavigationController;
  final Widget leading;
  final Widget trailing;
  final String title;
  final int selectedIndex;

  SchemeNavigationBar({
    this.properties,
    this.scrollNavigationController,
    this.navigationType = SchemeNavigationType.top,
    this.items,
    this.selectedIndex,
    this.enableAnimation = true,
    this.enableIconAnimation = false,
    this.title,
    this.collapseOnScroll = false,
    this.navBarStyle = SchemeBarStyle.flat,
    this.onDestinationSelected,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final indexStream = useStream(scrollNavigationController.pageStream);

    NavBarItemData selectedItem = items != null &&
            indexStream.data != null &&
            indexStream.hasData &&
            indexStream.data < items.length
        ? items[indexStream.data]
        : null;
    int currentIndex = selectedIndex ?? indexStream.data;
    if (collapseOnScroll && scrollNavigationController != null) {
      return pageBuilder(selectedItem, indexStream.data);
    }
    return navigationBar(selectedItem, currentIndex);
  }

  navigationBar(NavBarItemData selectedItem, int currentIndex) =>
      AnimatedContainer(
        duration: normalDuration,
        alignment: Alignment.center,
        height: properties != null ? properties.height : 72,
        decoration: BoxDecoration(
          color: properties.backgroundColor,
          boxShadow: properties.boxShadow ??
              [
                BoxShadow(blurRadius: 16, color: Colors.black12),
                BoxShadow(blurRadius: 24, color: Colors.black12),
              ],
        ),
        child: ClippedView(
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.horizontal,
              itemCount: items != null ? items.length : 0,
              itemBuilder: (context, index) =>
                  initNavButton(index, selectedItem, currentIndex)),
        ),
      );

  itemExtent(double adjustedAmount) {
    double width = 0.00;
    items.forEach((element) {
      width += element.width;
    });
    width /= items.length;
    return width + adjustedAmount;
  }

  initNavButton(int index, NavBarItemData selectedItem, int currentIndex) {
    switch (navBarStyle) {
      case SchemeBarStyle.flat:
        return BottomNavButton(
          data: items[index],
          index: index,
          parentColor: properties.backgroundColor,
          selectedIndex: currentIndex,
          isSelected: selectedItem == items[index],
          onTap: () => onTap(index),
        );
      case SchemeBarStyle.neu:
        return Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: NeuNavButton(
            data: items[index],
            index: index,
            parentColor: properties.backgroundColor,
            selectedColor: selectedItem.selectedColor,
            selectedIndex: currentIndex,
            enableAnimation: enableAnimation,
            enableIconAnimation: enableIconAnimation,
            isSelected: selectedItem == items[index],
            onTap: () => onTap(index),
          ),
        );
      case SchemeBarStyle.classic:
        return initToolbar(currentIndex);
      case SchemeBarStyle.fading:
        return FadingAppBar(
          scrollController: scrollNavigationController.scrollController,
          title: barBody(currentIndex),
        );

      case SchemeBarStyle.flare:
        // TODO: Handle this case.
        break;
    }
  }

  initToolbar(int currentIndex) {
    switch (properties.barAlignment) {
      case BarAlignment.start:
        return NavigationToolbar(
          leading: leading ?? SizedBox.shrink(),
          centerMiddle: true,
          middle: barBody(currentIndex),
          trailing: trailing ?? SizedBox.shrink(),
        );
      case BarAlignment.end:
        return NavigationToolbar(
          leading: leading ?? SizedBox.shrink(),
          trailing: barBody(currentIndex),
        );
      case BarAlignment.center:
        return NavigationToolbar(
          middle: barBody(currentIndex),
          centerMiddle: true,
        );
    }
  }

  barBody(int currentIndex) => ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) => SchemeButton(
          textStyle: currentIndex == index
              ? properties.selectedTextStyle
              : properties.unSelectedTextStyle,
          iconData: items[index].iconData,
          iconSize: items[index].iconSize,
          iconColor: currentIndex == index
              ? properties.selectedTheme.color
              : properties.unSelectedTheme.color,
          label: items[index].title,
          onTap: () => onTap(index),
        ),
      );

  onTap(int index) {
    scrollNavigationController.changePage(index);
    if (onDestinationSelected != null) onDestinationSelected(index);
  }

  Widget pageBuilder(NavBarItemData selectedItem, int currentIndex) {
    return StreamBuilder(
        stream: scrollNavigationController.pinStream,
        builder: (context, snapshot) {
          return _pinBuilder(context, snapshot, selectedItem, currentIndex);
        });
  }

  Widget _pinBuilder(BuildContext context, AsyncSnapshot<bool> pinSnapshot,
      NavBarItemData selectedItem, int currentIndex) {
    if (!pinSnapshot.hasData || pinSnapshot.data) {
      return _align(1.0, selectedItem, currentIndex);
    }
    return StreamBuilder(
      stream: scrollNavigationController.heightFactorStream,
      builder: (context, snapshot) =>
          _heightFactorBuilder(context, snapshot, selectedItem, currentIndex),
    );
  }

  Widget _heightFactorBuilder(
      BuildContext context,
      AsyncSnapshot<double> heightFactorSnapshot,
      NavBarItemData selectedItem,
      int currentIndex) {
    return _align(
        heightFactorSnapshot?.data ?? 1.0, selectedItem, currentIndex);
  }

  Widget _align(
      double heightFactor, NavBarItemData selectedItem, int currentIndex) {
    return Align(
      heightFactor: heightFactor,
      alignment: Alignment(0, -1),
      child: _elevation(heightFactor, selectedItem, currentIndex),
    );
  }

  Widget _elevation(
      double heightFactor, NavBarItemData selectedItem, int currentIndex) {
    return Material(
      elevation: properties.elevation,
      child: _decoratedContainer(heightFactor, selectedItem, currentIndex),
    );
  }

  Widget _decoratedContainer(
      double heightFactor, NavBarItemData selectedItem, int currentIndex) {
    return Container(
      height: scrollNavigationController.height,
      decoration: BoxDecoration(
        color: properties.backgroundColor,
      ),
      child: _opacity(heightFactor, selectedItem, currentIndex),
    );
  }

  Widget _opacity(
      double heightFactor, NavBarItemData selectedItem, int currentIndex) {
    return Opacity(
      opacity: heightFactor,
      child: navigationBar(selectedItem, currentIndex),
    );
  }
}
