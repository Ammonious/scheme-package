import 'package:flutter/material.dart';
import 'package:scheme_package/src/icons/constants/box_icons.dart';

import '../../scheme_package.dart';
import 'package:scheme_theme/scheme_theme.dart';

class NeuCheckBox extends StatelessWidget {
  final NeumorphicProperties neumorphicProperties;
  final Color parentColor;
  final bool isSelected;
  final Widget icon;
  final IconData iconData;
  final Color selectedColor;
  final Function onTap;
  final double size;
  NeuCheckBox(
      {Key key,
      this.neumorphicProperties,
      this.parentColor,
      this.isSelected,
      this.icon,
      this.iconData,
      this.selectedColor,
      this.onTap,
      this.size = 32})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => onTap(),
        child: NeumorphicContainer(
          width: size,
          decoration: NeumorphicDecoration(
            borderRadius: BorderRadius.circular(
                this.neumorphicProperties == null ? 15.0 : this.neumorphicProperties.borderRadius),
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
          height: size,
          child: Center(
            child: initChild(),
          ),
        ),
      ),
    );
  }

  initChild() {
    if (icon != null) return innerItem;
    if (iconData != null) return iconView;
  }

  get innerItem => Visibility(
        visible: icon != null,
        child: Container(
          padding: EdgeInsets.only(bottom:4),

          child: IconTheme(
            data: IconThemeData(
                color: isSelected
                    ? (selectedColor != null ? selectedColor : parentColor.textColor)
                    : parentColor.textColor),
            child: icon,
          ),
        ),
      );

  get iconView => Visibility(
        visible: iconData != null,
        child: Container(
          padding: EdgeInsets.only(bottom: 4),

          child: Icon(
            iconData ?? BoxIcon.bxCheck,
            color: isSelected
		            ? (selectedColor != null ? selectedColor : parentColor.textColor)
		            : parentColor.textColor,
          ),
        ),
      );
}
