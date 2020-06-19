import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart' hide CurveType;
import 'package:scheme_package/src/icons/constants/box_icons.dart';

import 'neu_container.dart';
import 'package:scheme_theme/scheme_theme.dart';

class NeuIconButton extends HookWidget {
  final Function onTap;
  final IconData iconData;
  final double size;
  final double iconSize;
  final Color iconColor;
  final double borderRadius;
  final NeumorphicProperties neumorphicProperties;
  final Color parentColor;
  final Color themeColor;
  NeuIconButton(
      {Key key,
      this.onTap,
      this.iconData,
      this.size = 52,
      this.iconSize = 20,
      this.iconColor = nearlyBlack,
      this.borderRadius = 12,
      this.neumorphicProperties,
      this.parentColor,
      this.themeColor })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedNotifier = useState<bool>(false);
    Color selectedColor = themeColor!= null ? themeColor : Colors.blueAccent.shade700;
    final iconsColor = iconColor ?? parentColor.textColor;
    bool isSelected = selectedNotifier.value;
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTapDown: (detail) => _handlePress(selectedNotifier),
        onTapUp: (details) => _resetIfTapUp(selectedNotifier),
        onTapCancel: () => _resetIfTapUp(selectedNotifier),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NeumorphicContainer(
              decoration: NeumorphicDecoration(
                borderRadius: BorderRadius.circular(this.neumorphicProperties == null
                    ? borderRadius
                    : this.neumorphicProperties.borderRadius),
                color: parentColor ?? neuBackground,
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
              width: size,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Icon(
                  iconData ?? BoxIcon.bxCheck,
                  color: isSelected ? selectedColor : iconsColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _resetIfTapUp(ValueNotifier selectedNotifier) {
    if (selectedNotifier.value) {
      if (onTap != null) onTap();
      selectedNotifier.value = false;
    }
  }

  Future<void> _handlePress(ValueNotifier selectedNotifier) async {
    if (!selectedNotifier.value) selectedNotifier.value = true;
  }
}
