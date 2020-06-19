// Handle the transition between selected and de-deselected, by animating it's own width,
// and modifying the color/visibility of some child widgets
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scheme_package/scheme_package.dart' hide CurveType;
import 'package:scheme_package/src/icons/constants/box_icons.dart';
import 'package:scheme_theme/scheme_theme.dart';

class NeuNavButton extends HookWidget {
  final NavBarItemData data;
  final int selectedIndex;
  final int index;
  final Function onTap;
  final bool isSelected;
  final Color parentColor;
  final Color selectedColor;
  final NeumorphicProperties neumorphicProperties;
  final double iconSize;
  final double height;
  final bool enableAnimation;
  final bool enableIconAnimation;
  NeuNavButton({
    this.enableAnimation = true,
    this.selectedColor,
    @required this.onTap,
    this.data,
    this.selectedIndex = 0,
    this.height = 42,
    this.iconSize = 20,
    this.neumorphicProperties,
    this.isSelected = false,
    this.index,
    this.parentColor,
    this.enableIconAnimation = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: NeumorphicContainer(
              decoration: NeumorphicDecoration(
                borderRadius: BorderRadius.circular(this.neumorphicProperties == null
                    ? 15.0
                    : this.neumorphicProperties.borderRadius),
                color: parentColor,
                border: this.neumorphicProperties == null ? null : this.neumorphicProperties.border,
                shape: this.neumorphicProperties == null
                    ? BoxShape.rectangle
                    : this.neumorphicProperties.shape,
              ),
              bevel: this.neumorphicProperties == null ? 12.0 : this.neumorphicProperties.bevel,
              curveType: isSelected
                  ? NeuCurveType.emboss
                  : this.neumorphicProperties == null
                      ? NeuCurveType.concave
                      : this.neumorphicProperties.curveType,
              height: height,
              child: Padding(
                padding: EdgeInsets.only(
                    left: isSelected ? 12 : 18, right: isSelected ? 12 : 18, top: 8, bottom: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (data.icon != null) innerItem,
                    if (data.iconData != null) enableIconAnimation ? animatedIcon : iconView,
                    enableAnimation
                        ? AnimatedCrossFade(
                            duration: Duration(milliseconds: 350),
                            firstChild: textView,
                            secondChild: SizedBox.shrink(),
                            crossFadeState:
                                isSelected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                          )
                        : textView
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  get animatedIcon => AnimatedCrossFade(duration: Duration(milliseconds: 200) ,  firstChild: iconView,secondChild: SizedBox.shrink(),crossFadeState: isSelected ? CrossFadeState.showFirst : CrossFadeState.showSecond,);

  get textView => Text(data.title,
      style: GoogleFonts.raleway(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: isSelected ? selectedColor : parentColor.textColor));

  get innerItem => Visibility(
        visible: data.icon != null,
        child: Padding(
          padding: EdgeInsets.only(right: enableAnimation && isSelected ? 8.0 : 2),
          child: IconTheme(
            data: IconThemeData(
                size: iconSize,
                color: isSelected
                    ? (selectedColor == null ? selectedColor : parentColor.textColor)
                    : parentColor.textColor),
            child: data.icon,
          ),
        ),
      );

  get iconView => Visibility(
        visible: data.iconData != null,
        child: Container(
          margin: EdgeInsets.only(right: (enableAnimation || enableIconAnimation) && isSelected ? 8.0 : 2),
          child: Icon(
            data.iconData ?? BoxIcon.bxCheck,
            color: isSelected ? selectedColor : parentColor.textColor,
          ),
        ),
      );
}
