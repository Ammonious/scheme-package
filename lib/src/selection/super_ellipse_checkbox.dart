import 'package:flutter/material.dart';
import 'package:scheme_package/src/icons/constants/box_icons.dart';

import '../../scheme_package.dart';
import 'package:scheme_theme/scheme_theme.dart';

class SuperEllipseCheckbox extends StatelessWidget {
  final bool selected;
  final Color themeColor;
  final Function onTap;
  final double size;
  final double iconSize;
  final List<BoxShadow> boxShadow;
  SuperEllipseCheckbox(
      {Key key,
      this.selected,
      this.themeColor = Colors.blue,
      this.onTap,
      this.size = 32,
        this.boxShadow,
      this.iconSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ThemeGradientIconButton(
        color: selected ? themeColor : Colors.grey.shade300,
        onTap: () => onTap != null ? onTap() : null,
        icon: BoxIcon.bxCheck,
        borderRadius: BorderRadius.circular(size * .8),
        iconColor: selected ? themeColor.shade700.textColor :  Colors.grey.shade300.textColor,
        boxShadow: boxShadow ?? normalShadow,
        size: size,
        iconSize: iconSize,
      ),
    );
  }
}
