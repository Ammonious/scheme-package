import 'package:flutter/material.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';
import 'package:scheme_package/src/icons/flare_icon.dart';
import 'package:scheme_package/src/icons/scheme_icon.dart';
import 'package:scheme_package/src/navigation/utils/selection_notifier.dart';
import 'package:supercharged/supercharged.dart';

import '../../../../scheme_package.dart';
import '../bottom_nav_bar_utils.dart';

class HorizontalNavButton extends StatelessWidget {
  final NavBarItemData data;
  final int selectedIndex;
  final int index;
  final bool isSelected;  
  final SchemeBarStyle schemeBarStyle;
  final FlareIconController controller;
  HorizontalNavButton(  {
    this.data,
    this.selectedIndex = 0,
    this.isSelected,
    this.schemeBarStyle = SchemeBarStyle.flat,
    this.index, this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor  = data.selectedScheme != null ? data.selectedScheme.primary : data.selectedColor != null ? data.selectedColor : Colors.white;
    final unSelectedColor  = data.unSelectedScheme != null ? data.unSelectedScheme.primary : data.unSelectedColor != null ? data.unSelectedColor : Colors.white.withOpacity(0.65);
    final textColor = isSelected ? selectedColor : unSelectedColor;
    var content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _schemeIcon(isSelected),
        SizedBox(width: 12),
        Text(
          data.title,
          style: data.textStyle != null ? data.textStyle.copyWith(
              color: textColor) : proxima_subtitle2.copyWith(color: textColor),
        ),
      ],
    );

    return AnimatedContainer(
      alignment: Alignment.center,
      width: isSelected ? data.width : 56,
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.all(12),
      duration: Duration(milliseconds: 700),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: ClippedView(
        child: content,
      ),
    );
  }


  Widget _schemeIcon(isSelected) {
    switch (schemeBarStyle) {
      case SchemeBarStyle.flat: 
      case SchemeBarStyle.neu: 
      case SchemeBarStyle.classic: 
      case SchemeBarStyle.fading:
      case SchemeBarStyle.flare:
        return SchemeIcon.flare(
          flareIcon: data.flareIcon,
          size: data.iconSize,
          controller: controller,
          colorScheme: isSelected ? data.selectedScheme : data.unSelectedScheme,
          animation: isSelected ? 'select' : 'idle',
        );
      default: return SchemeIcon.flare(
        flareIcon: data.flareIcon,
        size: data.iconSize,
        controller: controller,
        colorScheme: isSelected ? data.selectedScheme : data.unSelectedScheme,
        animation: isSelected ? 'select' : 'idle',
      );
    }
  }



}