import 'package:flutter/material.dart';
import 'package:scheme_package/src/neumorphic/neu_container.dart';
import 'package:scheme_theme/scheme_theme.dart';

import '../../scheme_package.dart';

class SchemeButtonProperties {
  final bool isLoading;
  final double height;
  final Color parentColor;
  final NeumorphicProperties neumorphicProperties;
  final IconData iconData;
  final double iconSize;
  final Color iconColor;
  final Color textColor;
  final Function onTap;
  final String label;
  final TextStyle textStyle;
  final bool isSelected;
  final double width;
  final Widget child;
  final IconData icon;
  final double size;
  final List<BoxShadow> boxShadow;
  final double padding;
  final Color color;
  final LinearGradient gradient;
  final BorderRadius borderRadius;
  final double borderWidth;
  final Color borderColor;
  final bool superEllipseShape;
  SchemeButtonProperties(
      {this.height = 50,
      this.width = 200,
      this.parentColor = Colors.white,
      this.neumorphicProperties,
      this.iconData,
      this.iconSize = 24,
      this.iconColor = nearlyBlack,
      this.textColor = nearlyBlack,
      this.onTap,
      this.label = '',
      this.textStyle,
      this.isSelected = false,
      this.child,
      this.icon,
      this.size = 50,
      this.boxShadow,
      this.padding,
      this.color = Colors.pink,
      this.gradient,
      this.borderRadius,
      this.borderWidth = 2,
      this.borderColor = Colors.grey,
      this.superEllipseShape = false,
      this.isLoading = false});
}
