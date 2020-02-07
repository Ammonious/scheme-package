
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
        // TODO: Handle this case.
        return TopRightPosition(
          vPadding: verticalPosition,
          hPadding: horizontalPosition,
          child: child,
        );
      case BubblePosition.TopLeft:
        // TODO: Handle this case.
        return TopLeftPosition(
          vPadding: verticalPosition,
          hPadding: horizontalPosition,
          child: child,
        );
      case BubblePosition.BottomRight:
        // TODO: Handle this case.
        return BottomRightPosition(
          vPadding: verticalPosition,
          hPadding: horizontalPosition,
          child: child,
        );
      case BubblePosition.BottomLeft:
        // TODO: Handle this case.
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
