import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/icons/flare_icon.dart';
import 'package:scheme_package/src/icons/scheme_icon.dart';
import 'package:scheme_package/src/navigation/scheme_nav_bar/navigation_items/horizontal_navigation_item.dart';
import 'package:scheme_package/src/navigation/utils/selection_notifier.dart';

class SchemeItemTile extends HookWidget {
  final bool selectedLabelVisible;
  final bool unselectedLabelVisible;
  final Gradient selectedGradient;
  final Gradient unSelectedGradient;
  final SelectionNotifier notifier;
  final SelectionStyle selectionStyle;
  final SchemeBarStyle schemeBarStyle;
  final NavBarItemData itemData;
 final FlareIconController controller;
  final int index;
  SchemeItemTile._internal({
    @required this.itemData,
    @required this.index,
    this.selectedLabelVisible,
    this.unselectedLabelVisible,
    this.selectedGradient,
    this.unSelectedGradient,
    this.notifier,
    this.selectionStyle,
    this.controller,
    this.schemeBarStyle = SchemeBarStyle.flat,
  });

  factory SchemeItemTile.flare(
      {String flareIcon,
        @required int index,
      @required  NavBarItemData itemData,
      @required SelectionNotifier notifier,
        @required   FlareIconController controller,
      bool selectedLabelVisible = false,
      bool unselectedLabelVisible = false,  }) {
    return SchemeItemTile._internal(
      notifier: notifier,
      selectedLabelVisible: selectedLabelVisible,
      unselectedLabelVisible: unselectedLabelVisible,
      schemeBarStyle: SchemeBarStyle.flare,
      controller: controller,
      index: index,
      itemData: itemData,
    );
  }

  @override
  Widget build(BuildContext context) {
    final stream = useStream(notifier.indexStream);
    final bool isSelected = stream.hasData ? stream.data == index : index == 0;


    controller.colorScheme = isSelected ? itemData.selectedScheme : itemData.unSelectedScheme;
    if(!isSelected) controller.play('deselect');
    controller.isActive.value = true;

      return GestureDetector(
        onTap: () => notifier.selectIndex(index),
        child: _getLabeledItem(isSelected),
      );
  }

  Widget _getLabeledItem(isSelected) {
    return HorizontalNavButton(
      selectedIndex: notifier.currentIndex,
      controller: controller,
      index: index,
      isSelected: isSelected,
      data: itemData,
      schemeBarStyle: SchemeBarStyle.flare,
    );
  }

  Widget _getThemedIcon(isSelected) {
    switch (schemeBarStyle) {
      case SchemeBarStyle.flat:
        break;
      case SchemeBarStyle.neu:
        break;
      case SchemeBarStyle.classic:
        break;
      case SchemeBarStyle.fading:
        break;
      case SchemeBarStyle.flare:
        return SchemeIcon.flare(
          flareIcon: itemData.flareIcon,
          size: itemData.iconSize,
          controller: controller,
          colorScheme: isSelected ? itemData.selectedScheme : itemData.unSelectedScheme,
          animation: isSelected ? 'select' : 'idle',
        );
    }
  }
}

enum SelectionStyle {
  color,
  opacity,
}
