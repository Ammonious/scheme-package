import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_theme/scheme_theme.dart';

class TabButtonBar extends StatelessWidget {
  final int selectedIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<TabItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;
  final Color brandColor;
  final double buttonWidth;

  TabButtonBar({
    Key key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    @required this.items,
    @required this.onItemSelected,
    this.curve = Curves.linear, this.brandColor, this.buttonWidth,
  }) {
    assert(items != null);
    assert(items.length >= 2 && items.length <= 5);
    assert(onItemSelected != null);
    assert(curve != null);
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: bgColor,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,brandColor: brandColor,width: buttonWidth,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final TabItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;
  final Color brandColor;
  final double width;

  const _ItemWidget({
    Key key,
    @required this.item,
    @required this.isSelected,
    @required this.backgroundColor,
    @required this.animationDuration,
    @required this.itemCornerRadius,
    @required this.iconSize,
    this.curve = Curves.linear,
    this.brandColor,
    this.width = 130,
  })  : assert(isSelected != null),

        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: width,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          gradient: isSelected
              ? schemeGradient(
                  colorOne: brandColor.shade500, colorTwo: brandColor.shade700)
              : null,
          color: !isSelected ? Colors.grey.withOpacity(0.35) : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius),
          boxShadow: isSelected ? normalShadow : flatShadow
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            width: width,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                item.icon != null
                    ? IconTheme(
                        data: IconThemeData(
                          size: iconSize,
                          color: isSelected
                              ? item.activeColor.withOpacity(1)
                              : item.inactiveColor == null
                                  ? item.activeColor
                                  : item.inactiveColor,
                        ),
                        child: item.icon,
                      )
                    : SizedBox.shrink(),
                  item.icon != null
                      ? Expanded(
                          child: innerView,
                        )
                      : innerView,
              ],
            ),
          ),
        ),
      ),
    );
  }

  get innerView => Container(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Center(child: DefaultTextStyle.merge(
          style: item.textStyle.copyWith(color: isSelected ? brandColor.shade700.textColor : backgroundColor.textColor) ?? TextStyle(
            color: isSelected ? brandColor.shade700.textColor : backgroundColor.textColor,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          textAlign: item.textAlign,
          child: item.title,
        ),),
      );
}

class TabItem {
  final Icon icon;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;
  final TextAlign textAlign;
  final TextStyle textStyle;
  TabItem( {this.textStyle,
     this.icon,
     this.title,
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inactiveColor,
  });
}
