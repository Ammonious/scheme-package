import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/navigation/scheme_nav_bar/views/scheme_indicator.dart';
import 'package:scheme_package/src/navigation/utils/selection_notifier.dart';

class SchemeIndicatorView extends StatefulWidget {
  final int itemsCount;
  final SchemeIndicator shape;
  final Gradient snakeColor;
  final double widgetEdgePadding;
  final SelectionNotifier notifier;
  final Duration animationDuration;
  final Duration delayTransition;
  final Curve snakeCurve;
  final double circlePadding;
  final double indicatorHeight;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;
  final List<NavBarItemData> items;
  SchemeIndicatorView({
    @required this.itemsCount,
    @required this.shape,
    @required this.widgetEdgePadding,
    @required this.notifier,
    this.animationDuration = const Duration(milliseconds: 200),
    this.delayTransition = const Duration(milliseconds: 50),
    this.snakeCurve = Curves.easeInOut,
    this.circlePadding = 4,
    this.indicatorHeight = 4,
    @required this.showSelectedLabels,
    @required this.snakeColor, this.items, this.showUnselectedLabels = false,
  });

  @override
  _SchemeIndicatorViewState createState() => _SchemeIndicatorViewState();
}

class _SchemeIndicatorViewState extends State<SchemeIndicatorView> {
  int snakeSize = 1;
  int currentIndex;
  double oneItemWidth;
  double prevItemWidth;
  Orientation orientation;
  SchemeIndicatorType get type => widget.shape.type;

  List<NavBarItemData> get items => widget.items;

  @override
  Widget build(BuildContext context) {

    if(oneItemWidth == null) oneItemWidth = items[0].width - (widget.widgetEdgePadding + 24);

    widget.notifier.addListener(() {
      int newSnakeSize;
      int _currentIndex = widget.notifier.currentIndex;

      int lastIndex = widget.notifier.lastIndex;
      NavBarItemData currentItem  = items[currentIndex];
      NavBarItemData lastItem  = items[currentIndex];
      oneItemWidth = currentItem.width - (widget.widgetEdgePadding + 24);
      if (lastIndex < _currentIndex) {
        //region going right
        newSnakeSize =
            _currentIndex + 1 -lastIndex;
        setState(() => snakeSize = newSnakeSize);
        Future.delayed(
            widget.animationDuration + widget.delayTransition,
                () => setState(() {
              snakeSize = 1;

            }));
        //endregion
      } else if (lastIndex > _currentIndex) {
        //region going left
        newSnakeSize =
            (currentIndex - lastIndex).abs();
        setState(() {

          snakeSize = newSnakeSize + 1;
        });
        Future.delayed(widget.animationDuration + widget.delayTransition,
                () => setState(() => snakeSize = 1));
        //endregion
      } else {
        //the same place
        newSnakeSize = snakeSize;
      }
      currentIndex = widget.notifier.currentIndex;
    });

    if (currentIndex == null ||
        currentIndex != currentIndex ||
        orientation != MediaQuery.of(context).orientation ||
        prevItemWidth != oneItemWidth) {
      currentIndex = widget.notifier.currentIndex;
      orientation = MediaQuery.of(context).orientation;
      prevItemWidth = widget.showUnselectedLabels ? oneItemWidth : 56; // 56 + padding on left/right of 4.
    }

    EdgeInsets viewPadding = widget.shape.type == SchemeIndicatorType.circle ||
        widget.shape.centered
        ? EdgeInsets.symmetric(
      vertical: widget.circlePadding,
      horizontal: (oneItemWidth -
          (kBottomNavigationBarHeight - widget.circlePadding * 2)) /
          2,
    )
        : EdgeInsets.only(left: 12,right: 12);

    double snakeViewWidth =
    widget.shape.type == SchemeIndicatorType.circle || widget.shape.centered
        ? oneItemWidth * snakeSize - (viewPadding.left + viewPadding.right)
        : oneItemWidth * snakeSize;

    return AnimatedPositioned(
      left: offset(widget.notifier.currentIndex),
      duration: widget.animationDuration,
      curve: widget.snakeCurve,
      child: AnimatedPadding(
        duration: widget.animationDuration,
        padding: viewPadding,
        child: AnimatedContainer(
          curve: widget.snakeCurve,
          duration: widget.animationDuration,
          width: snakeViewWidth,
          height: _snakeViewHeight(),
          child: Material(
            shape: _snakeShape(),
            clipBehavior: Clip.antiAlias,
            child: Container(
                decoration: BoxDecoration(gradient: widget.snakeColor)),
          ),
        ),
      ),
    );
  }

  double _snakeViewHeight() {
    switch (type) {
      case SchemeIndicatorType.circle:
        return kBottomNavigationBarHeight - widget.circlePadding * 2;
        break;
      case SchemeIndicatorType.rectangle:
        return kBottomNavigationBarHeight;
        break;
      case SchemeIndicatorType.indicator:
        return widget.indicatorHeight;
        break;
      case SchemeIndicatorType.custom:
        return widget.shape.centered
            ? kBottomNavigationBarHeight - widget.circlePadding * 2
            : kBottomNavigationBarHeight;
        break;
    }
    return -1;
  }

  ShapeBorder _snakeShape() {
    switch (type) {
      case SchemeIndicatorType.circle:
        return _getRoundShape(_snakeViewHeight() / 2);
      case SchemeIndicatorType.indicator:
        return indicatorShape;
      default:
        return widget.shape.shape;
        break;
    }
  }

  offset(int currentIndex){
    NavBarItemData currentItem  = items[currentIndex];
    if(widget.showUnselectedLabels){
      return currentItem.width * currentIndex;
    } else {
      return 56.0 * currentIndex;
    }

  }

  ShapeBorder _getRoundShape(double radius) => RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)));

  ShapeBorder get indicatorShape => RoundedRectangleBorder(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4),bottomRight: Radius.circular(4)));
}