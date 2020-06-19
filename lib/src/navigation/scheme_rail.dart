import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/icons/flare_icon.dart';
import 'package:scheme_package/src/icons/scheme_icon.dart';
import 'package:scheme_package/src/navigation/model/nav_data.dart';
import 'package:scheme_package/src/navigation/model/scheme_nav_properties.dart';

class SchemeNavRail extends NavigationRail {
  final List<NavBarItemData> items;
  final int selectedIndex;
  final SchemeNavProperties properties;
  final Function(int index) onDestinationSelected;
  final Widget header;
  final Widget footer;
  final FlareIconController controller;

  SchemeNavRail({this.controller,
    this.header,
    this.footer,
    this.properties,
    this.onDestinationSelected,
    this.items,
    this.selectedIndex,
  }) : super(
      leading: header,
      trailing: footer,
      backgroundColor: properties.backgroundColor,
      elevation: properties.elevation,
      labelType: properties.railLabelType,
      extended: properties.extended,
      unselectedIconTheme: properties.unSelectedTheme,
      selectedIconTheme: properties.unSelectedTheme,
      selectedLabelTextStyle: properties.selectedTextStyle,
      unselectedLabelTextStyle: properties.unSelectedTextStyle,
      groupAlignment: initAlignment(properties),
      minExtendedWidth: properties.minExtendedWidth,
      minWidth: properties.minWidth,
      destinations: items != null
          ? List.from(items.map((e) =>
          NavigationRailDestination(
              icon: schemeIcon(properties, e),
              selectedIcon: schemeIcon(properties, e),
              label: e.label ??
                  Text(
                    e.title,
                  ))))
          : List<NavigationRailDestination>(),
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) => onDestinationSelected(index));
}


initAlignment(SchemeNavProperties properties) {
  switch (properties.railAlignment) {
    case RailAlignment.top:
      return -1;
    case RailAlignment.bottom:
      return 1;
    case RailAlignment.center:
      return 0;
  }
}
  schemeIcon(SchemeNavProperties properties,NavBarItemData data) => _schemeIcon(properties, data);
   Widget _schemeIcon(SchemeNavProperties properties, NavBarItemData data) {
    switch (properties.schemeBarStyle) {
      case SchemeBarStyle.flat:
      case SchemeBarStyle.neu:
      case SchemeBarStyle.classic:
      case SchemeBarStyle.fading:
      case SchemeBarStyle.flare:
        return SchemeIcon.flare(
          flareIcon: data.flareIcon,
          size: data.iconSize,
          colorScheme: data.selectedScheme,
          animation: 'idle',
        );
      default: return SchemeIcon.flare(
        flareIcon: data.flareIcon,
        size: data.iconSize,
        colorScheme: data.selectedScheme,
        animation: 'idle',
      );
    }
  }

