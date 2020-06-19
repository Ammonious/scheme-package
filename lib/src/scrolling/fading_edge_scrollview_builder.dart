import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';

class FadingScrollViewBuilder extends StatefulWidget {
  final ListView listView;
  final Widget child;
  final Widget Function(BuildContext context, double opacity, Widget child)
      builder;

  FadingScrollViewBuilder(
      {Key key, this.builder, this.child,@required this.listView})
      : super(key: key);

  @override
  _FadingScrollViewBuilderState createState() =>
      _FadingScrollViewBuilderState();
}

class _FadingScrollViewBuilderState extends State<FadingScrollViewBuilder> {
  double offset = 0.0;
  double opacity = 0.9;
  double childOpacity = 1.0;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollNotification) {
            offset = notification.metrics.pixels;
            if(offset >= 72 && opacity != 0.0){
              setState(() {
                opacity = 0.0;
                childOpacity = 0.0;
              });
            } else if(offset < 72 && opacity != 0.9) {
              setState(() {
                opacity = 0.9;
                childOpacity = 1.0;
              });
            }
            return true;
          }
          return false;
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            FadingEdgeScrollView.fromScrollView(
                gradientFractionOnEnd: opacity,
                child: widget.listView),
            if (widget.builder != null)
              Positioned(right: 8, child: widget.builder(context, childOpacity, widget.child),),
          ],
        ),
      ),
    );
  }
}
