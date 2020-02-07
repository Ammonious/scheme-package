
import 'package:flutter/material.dart';
import 'package:scheme_package/src/global_widgets/custom_image.dart';
import 'package:scheme_package/src/utils/constants.dart';
import 'package:scheme_package/src/utils/scroll_methods.dart';

import 'bubble_decoration.dart';
import 'decoration_positioner.dart';

class LogoDecoration extends StatefulWidget {
  final String imageUrl;
  final double size;
  final double width;
  final double height;
  final Color brandColor;
  final ScrollController scrollController;
  final bool enableOverlay;
  final double beginningOpacity;
  final BubblePosition position;
  final double verticalPadding;
  final double horizontalPadding;
  final Color backgroundColor;
  LogoDecoration({
    Key key,
    this.imageUrl,
    this.size = 350,
    this.beginningOpacity = 0.35,
    this.horizontalPadding = -100,
    this.verticalPadding = -175,
    this.brandColor = Colors.blue,
    this.scrollController,
    this.enableOverlay = true,
    this.position = BubblePosition.TopRight, this.backgroundColor = background, this.width = 24, this.height = 24,
  }) : super(key: key);

  @override
  _LogoDecorationState createState() => _LogoDecorationState();
}

class _LogoDecorationState extends State<LogoDecoration> {
  ScrollController get scrollController => widget.scrollController ?? ScrollController();

  double opacity = 0.35;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    opacity = widget.beginningOpacity;
    scrollController.addListener(() {
      opacityOnScroll(
          scrollController: scrollController,
          opacity: opacity,
          onRefresh: (opacity) => setState(() {
                this.opacity = opacity;
              }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DecorationPositionView(
          horizontalPosition: widget.horizontalPadding,
          verticalPosition: widget.verticalPadding,
          position: widget.position,
          child: CustomImage(
            imageUrl: widget.imageUrl,
            width: widget.width,
            height: widget.height,
          ),
        ),
        DecorationPositionView(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: widget.size,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.3, 1],
                colors: [widget.backgroundColor, widget.backgroundColor.withOpacity(opacity)],
              ),
            ),
          ),
          position: widget.position,
          horizontalPosition: 0,
          verticalPosition: 0,
        )
      ],
    );
  }
}
