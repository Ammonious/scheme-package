import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sa_multi_tween/sa_multi_tween.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/animations/circular_reveal_animation.dart';
import 'package:scheme_package/src/decorations/shapes/superellipse_shape.dart';
import 'package:scheme_package/src/icons/constants/box_icons.dart';

import 'package:scheme_theme/scheme_theme.dart';

class SuperEllipseChip extends StatefulWidget {
  final Color selectedColor;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final bool selected;
  final double height;
  final String label;
  final TextStyle textStyle;
  final int duration;
  final Function(bool selected) onSelect;
  SuperEllipseChip({
    Key key,
    @required this.label,
    this.textStyle,
    this.selectedColor = Colors.blue,
    this.duration = 500,
    this.backgroundColor,
    this.borderColor = Colors.grey,
    this.borderWidth = 0,
    this.selected = false,
    this.onSelect,
    this.height = 32,
  }) : super(key: key);

  @override
  _SuperEllipseChipState createState() => _SuperEllipseChipState();
}

class _SuperEllipseChipState extends State<SuperEllipseChip> {
  get duration => widget.duration;
  Color get selectedColor => widget.selectedColor;
  CustomAnimationControl control = CustomAnimationControl.STOP;
  MultiTween<DefaultAnimationProperties> tween;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tween = MultiTween<DefaultAnimationProperties>()
      ..add(DefaultAnimationProperties.scale, 1.0.tweenTo(0.0), duration)
      ..add(DefaultAnimationProperties.scale, 0.0.tweenTo(1.0), duration)
      ..add(DefaultAnimationProperties.color, nearlyBlack.tweenTo(selectedColor.textColor), duration);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selected) {
      select();
    } else {
      deSelect();
    }
    return Material(
      color: Colors.transparent,
      child: CustomAnimation(
        tween: tween,
        duration: Duration(milliseconds: duration),
        control: control,
        builder: (context,child, animation) => GestureDetector(
          onTap: () => onTap(widget.selected),
          child: Container(
            clipBehavior: Clip.antiAlias,
            height: widget.height,
            decoration: ShapeDecoration(
                shape: SuperellipseShape(
                    side: BorderSide(
                        color: widget.selected ? Colors.transparent : widget.borderColor,
                        width: widget.selected ? 0 : widget.borderWidth),
                    borderRadius: BorderRadius.circular(widget.height * 0.65))),
            child: CustomPaint(
              painter: RevealPainter(fraction: animation['in'], color:  widget.selectedColor,centerOffset: Offset(11,(widget.height - 4) / 2)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 6, right: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Transform.scale(
                          scale: animation['out'],
                          child: Container(
                            height: 10,
                            width: 10,
                            margin: EdgeInsets.only(right: 6 * animation['out']),
                            decoration: BoxDecoration(
                                color: widget.selectedColor,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom:2),
                          child: Text(
                            widget.label,
                            style: widget.textStyle != null
                                ? widget.textStyle.copyWith(color: animation['color'])
                                : GoogleFonts.robotoMono(color: animation['color']),
                          ),
                        ),
                        Transform.scale(
                          scale: animation['in'],
                          child: Container(
                            height: 18,
                            width: 18,
                            margin: EdgeInsets.only(left: 4 * animation['in']),
                            child: Icon(
                              BoxIcon.bxX,
                              color: animation['color'],
                              size: 18,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onTap(bool selected) {
    if (selected) {
      if (widget.onSelect != null) widget.onSelect(false);
    } else {
      if (widget.onSelect != null) widget.onSelect(true);
    }
  }

  select() => setState(() {
    control = CustomAnimationControl.PLAY;
  });

  deSelect() => setState(() {
    control = CustomAnimationControl.PLAY_REVERSE;
  });

  get textColor => widget.selected ? widget.selectedColor.textColor : nearlyBlack;
}
