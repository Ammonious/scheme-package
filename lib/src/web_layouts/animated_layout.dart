import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';

class AnimatedLayout extends HookWidget {
  final List<Widget> children;
  final List<DecorationWidget> decorations;
  AnimatedLayout(
    this.decorations, {
    Key key,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
          child: Container(
        child: Stack(
          children: layoutChildren(),
        ),
      )),
    );
  }

  layoutChildren() {
    List<Widget> items = List();
    if (decorations != null) {
      decorations.forEach((element) => items.add(DecorationPositionView(
            position: element.position,
            child: element.child,
            verticalPosition: element.verticalOffset,
            horizontalPosition: element.horizontalOffset,
          )));
    }
  }


}
