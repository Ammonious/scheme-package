

import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/buttons/scheme_button_decoration.dart';
import 'package:scheme_package/src/icons/scheme_icon.dart';
import 'package:scheme_theme/scheme_theme.dart';

enum SchemeButtonStyle {
  neu,
  gradient,
  outline,
  loading,
  flat,
  icon,
  gradient_icon,
  raised
}

class SchemeButton extends StatelessWidget {
  final SchemeButtonStyle buttonStyle;
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
  final double size;
  final double padding;
  final Color color;
  final String imagePath;
  final String imageUrl;
  final String svgPath;
  final LinearGradient gradient;
  final SchemeButtonDecoration decoration;
  final ButtonTheme buttonTheme;
  final SchemeIconType iconType;
  final bool enabled;

  SchemeButton({Key key,
    this.buttonStyle = SchemeButtonStyle.gradient,
    this.height = 50,
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
    this.size = 50,
    this.padding,
    this.color = Colors.pink,
    this.gradient,
    this.isLoading = false,
    this.decoration,
    this.imagePath,
    this.imageUrl,
    this.svgPath,
    this.buttonTheme,
    this.iconType,
    this.enabled = true})
      : super(key: key);


  factory SchemeButton.neu({
    Function onTap,
    double width,
    double height,
    String label,
    Color parentColor,
    bool enabled,
    double bevel,
    double borderRadius,
    BoxBorder border,
    BoxShape shape,
    NeuCurveType curveType,
    bool showSubtitleText,
    IconData iconData,
    double iconSize,
    TextStyle textStyle,
    bool isSelected,
    Widget child,
    Color iconColor,}) {
    return SchemeButton(
      onTap: () => onTap(),
      width: width,
      height: height,
      label: label,
      parentColor: parentColor,
      enabled: enabled,
      neumorphicProperties: NeumorphicProperties(
          bevel: bevel,
          borderRadius: borderRadius,
          curveType: curveType,
          border: border,
          shape: shape,
          showSubtitleText: showSubtitleText),
      iconData: iconData,
      iconSize: iconSize,
      textStyle: textStyle,
      isSelected: isSelected,
      child: child,
      iconColor: iconColor);
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: initButton(),
    );
  }

  initButton() {
    SchemeButtonDecoration schemeDecoration = decoration;
    if (schemeDecoration == null)
      schemeDecoration = SchemeButtonDecoration.defaultValue();
    switch (buttonStyle) {
      case SchemeButtonStyle.neu:
        return NeuButton(
          onTap: () => onTap(),
          width: width,
          height: height,
          label: label,
          parentColor: color,
          enabled: enabled,
          neumorphicProperties: neumorphicProperties,
          iconData: iconData,
          iconSize: iconSize,
          textStyle: textStyle,
          isSelected: isSelected,
          child: child,
          iconColor: iconColor,
        );
      case SchemeButtonStyle.gradient:
        return GradientButton(
          onTap: () => onTap(),
          width: width,
          enabled: enabled,
          height: height,
          label: label,
          color: color,
          gradient: gradient,
          borderRadius: schemeDecoration.borderRadius,
          boxShadow: schemeDecoration.boxShadow,
          iconData: iconData,
          iconSize: iconSize,
          child: child,
          superEllipseShape: schemeDecoration.superEllipseShape,
          textStyle: textStyle,
        );
      case SchemeButtonStyle.outline:
        return ThemeOutlineButton(
          onTap: () => onTap(),
          width: width,
          height: height,
          label: label,
          enabled: enabled,
          child: child,
          borderRadius: schemeDecoration.borderRadius,
          borderColor: schemeDecoration.borderColor,
          borderWidth: schemeDecoration.borderWidth,
          icon: iconData,
          iconSize: iconSize,
          superellipseShape: schemeDecoration.superEllipseShape,
          textStyle: textStyle,
        );
      case SchemeButtonStyle.loading:
        return LoadingRoundButton(
          isLoading: isLoading,
          buttonGradient: gradient,
          boxShadow: schemeDecoration.boxShadow,
          onTap: () => onTap(),
        );
      case SchemeButtonStyle.flat:
        return ButtonTheme(
          height: height,
          child: FlatButton(
              textColor: textColor,
              child: label != null
                  ? Text(
                label,
                style: textStyle ?? schemeBtnFont,
              )
                  : child,
              onPressed: () => onTap != null && enabled ? onTap() : null),
        );
      case SchemeButtonStyle.icon:
        return InkWell(
            borderRadius: BorderRadius.circular(size * .5),
            onTap: () => onTap != null && enabled ? onTap() : null,
            child: SizedBox(
              height: size ?? kToolbarHeight,
              width: size ?? kToolbarHeight,
              child: SchemeIcon.icon(
                iconData: iconData,
                size: iconSize,
                color: iconColor,
              ),
            ));
      case SchemeButtonStyle.gradient_icon:
        return ThemeGradientIconButton(
          icon: iconData,
          size: size,
          iconSize: iconSize,
          color: color,
          gradient: gradient,
          boxShadow: schemeDecoration.boxShadow,
          padding: padding,
          enabled: enabled,
          iconColor: iconColor,
          onTap: () => onTap(),
        );
      case SchemeButtonStyle.raised:
        return Material(color: Colors.transparent,
          child: InkWell(borderRadius: schemeDecoration.borderRadius,
            onTap: () => enabled ? onTap() : null,
            child: AnimatedContainer(
              duration: normalDuration,
              height: height,
              width: width,
              padding: EdgeInsets.only(
                  left: padding, right: padding, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  boxShadow: schemeDecoration.boxShadow,
                  color: color,
                  borderRadius: schemeDecoration.borderRadius),
              child: label != null
                  ? Center(
                child: Text(
                  label,
                  style: textStyle ?? schemeBtnFont,
                ),
              )
                  : Center(child: child),
            ),
          ),
        );
    }
  }
}
