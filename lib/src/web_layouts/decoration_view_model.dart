import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/web_layouts/web_constants.dart';

class DecorationWidget {
  final Widget child;
  final BubblePosition position;
  final double verticalOffset;
  final double horizontalOffset;

  DecorationWidget({
    this.child,
    this.position = BubblePosition.TopCenter,
    this.verticalOffset = 0,
    this.horizontalOffset = 0,
  });
}

class FlexWidget extends StatelessWidget {
  final Widget child;
  final int flex;
  FlexWidget({Key key, this.child, this.flex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  child;
  }
}
