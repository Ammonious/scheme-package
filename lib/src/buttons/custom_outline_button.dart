import 'package:flutter/material.dart';

import '../../scheme_package.dart';
import 'button_constants.dart';

class ThemeOutlineButton extends StatelessWidget {
  final Function onTap;
  final String label;
  final double height;
  final double width;
  final double borderWidth;
  final IconData icon;
  final double iconSize;
  final Color borderColor;
  final TextStyle textStyle;
  final bool superellipseShape;
  final BorderRadius borderRadius;
  final Widget child;
  final bool enabled;
  const ThemeOutlineButton({
    Key key,
    this.onTap,
    this.label = '',
    this.child,
    this.height = 50,
    this.width = 200,
    this.textStyle,
    this.superellipseShape = false,
    this.borderWidth = 2,
    this.borderColor = Colors.grey,
    this.icon,
    this.iconSize = 24,
    this.borderRadius, this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.only(left: 8, right: 8),
      decoration: superellipseShape
          ? superEllipseOutline(borderWidth, borderColor,borderRadius: borderRadius)
          : regularOutline(borderWidth, borderColor),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          onTap: ()  => onTap != null && enabled ? onTap() : null,
          child: Container(
            child: Center(
              child: child != null ? child : icon != null
                  ? Row(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          icon,
                          size: iconSize,
                          color: borderColor,
                        ),
                        SizedBox(width: 10,),
                        Text(
                          label,
                          maxLines: 1,
                          style: textStyle == null ? GoogleFonts.roboto(color: borderColor) : textStyle.copyWith(color: borderColor),
                        ),
                      ],
                    )
                  : Text(
                      label,
                maxLines: 1,
                      style: textStyle == null ? GoogleFonts.roboto(color: borderColor) : textStyle.copyWith(color: borderColor),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
