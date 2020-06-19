
import 'package:flutter/material.dart';

import 'bubble_decoration.dart';
import 'position_containers.dart';

class DecorationPositionView extends StatelessWidget {
  final BubblePosition position;
  final Widget child;
  final double verticalPosition;
  final double horizontalPosition;
  DecorationPositionView(
      {Key key,
      this.position = BubblePosition.TopRight,
      this.child,
      this.verticalPosition,
      this.horizontalPosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (position) {
      case BubblePosition.TopRight:
        return TopRightPosition(
          vPadding: verticalPosition,
          hPadding: horizontalPosition,
          child: child,
        );
      case BubblePosition.TopLeft:
        return TopLeftPosition(
          vPadding: verticalPosition,
          hPadding: horizontalPosition,
          child: child,
        );
      case BubblePosition.TopCenter:
        return TopCenterPosition(
          vPadding: verticalPosition,
          child: child,
        );
      case BubblePosition.BottomCenter:
        return BottomCenterPosition(
          vPadding: verticalPosition,
          child: child,
        );
      case BubblePosition.BottomRight:
        return BottomRightPosition(
          vPadding: verticalPosition,
          hPadding: horizontalPosition,
          child: child,
        );
      case BubblePosition.BottomLeft:
        return BottomLeftPosition(
          vPadding: verticalPosition,
          hPadding: horizontalPosition,
          child: child,
        );
      default:
        return TopRightPosition(
          vPadding: verticalPosition,
          hPadding: horizontalPosition,
          child: child,
        );
    }
  }
}
