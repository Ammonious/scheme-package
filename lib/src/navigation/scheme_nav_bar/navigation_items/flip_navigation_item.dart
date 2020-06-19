import 'dart:core';
import 'package:scheme_package/src/navigation/utils/selection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/navigation/model/nav_data.dart';
import '../bottom_nav_bar_utils.dart';

import 'package:scheme_theme/scheme_theme.dart';
// Handle the transition between selected and de-deselected, by animating it's own width,
// and modifying the color/visibility of some child widgets
class BottomNavButton extends HookWidget {
  final NavBarItemData data;
  final int selectedIndex;
  final int index;
  final Function onTap;
  final bool isSelected;
  final Color parentColor;

  final SelectionNotifier notifier;
  BottomNavButton( {
    @required this.onTap,
    this.notifier,
    this.data,
    this.selectedIndex = 0,
    this.isSelected,
    this.index,
    this.parentColor,
  });

  @override
  Widget build(BuildContext context) {
    final control =
        useState<CustomAnimationControl>(CustomAnimationControl.PLAY);
    final refresh = useState(false);
    _startAnimIfSelectedChanged(selectedIndex, refresh, control);
    var content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomAnimation(
          duration: Duration(milliseconds: 350),
          tween: (0.0).tweenTo(1.0),
          control: control.value,
          builder: (context, child, progress) => Rotation3d(
            rotationY: 180.0 * progress,
            child: schemeIcon,
          ),
        ),
        SizedBox(width: 12),
        Text(
          data.title,
          style: data.textStyle.copyWith(
              color: isSelected
                  ? data.selectedColor != null ? data.selectedColor.textColor : Colors.white
                  : data.unSelectedColor),
        ),
      ],
    );

    return GestureDetector(
      onTap: () => onPressed(refresh),
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, right: 4, left: 4),
        child: AnimatedContainer(
          alignment: Alignment.center,
          width: isSelected ? data.width : 56,
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.all(12),
          duration: Duration(milliseconds: 700),
          decoration: BoxDecoration(
            color: isSelected ? data.selectedColor : parentColor,
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          child: ClippedView(
            child: content,
          ),
        ),
      ),
    );
  }

  onPressed(ValueNotifier refresh) {
    if (onTap != null) onTap();
    if(notifier != null) notifier.selectIndex(selectedIndex);
  }

  _startAnimIfSelectedChanged(int selectedIndex, ValueNotifier refresh,
      ValueNotifier<CustomAnimationControl> controller) {
    if (refresh.value != isSelected) {
      isSelected
          ? controller.value = CustomAnimationControl.PLAY
          : controller.value = CustomAnimationControl.PLAY_REVERSE;
    }
    refresh.value = isSelected;
  }

  get schemeIcon => isSvgIcon ? svgIcon : data.icon != null ? flareIcon : normalIcon;




  get isSvgIcon => data.icon != null && (data.selectedColor != null || data.unSelectedColor != null);

 get svgIcon => IconTheme(
    data: IconThemeData(
        color: isSelected
            ? data.selectedColor.textColor
            : data.unSelectedColor,
        size: data.iconSize),
    child: ColorFiltered(
      colorFilter: ColorFilter.mode(
          isSelected
              ? data.selectedColor.textColor
              : data.unSelectedColor,
          BlendMode.srcIn),
      child: data.icon,
    ),
  );


  get flareIcon => data.icon;

  get normalIcon => Icon(
    isSelected ? data.selectedIconData : data.iconData,
    size: data.iconSize,
    color: isSelected
        ? data.selectedColor.textColor
        : data.unSelectedColor,
  );
}
