
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scheme_package/src/global_widgets/images/custom_image.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'package:scheme_package/src/utils/scroll_methods.dart';

import 'bubble_decoration.dart';
import 'decoration_positioner.dart';

class LogoDecoration extends HookWidget {
  final String imageUrl;
  final String imagePath;
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
  final bool enableAnimation;
  final PublishSubject<double> scrollStream;
  LogoDecoration({
    Key key,
    this.imageUrl,
    this.beginningOpacity = 0.15,
    this.horizontalPadding = -100,
    this.verticalPadding = -175,
    this.brandColor = Colors.blue,
    this.scrollController,
    this.enableOverlay = true,
    this.position = BubblePosition.TopRight, this.backgroundColor = background, this.width = 24, this.height = 24, this.enableAnimation = true, this.imagePath, this.scrollStream,
  }) : super(key: key);
 
 

  @override
  Widget build(BuildContext context) {
    final stream = useStream(scrollStream);
    final opacity = stream != null && stream.hasData ? getOpacity(stream) : beginningOpacity;
    return AnimatedContainer(duration: Duration(milliseconds: 200),
      child: Stack(
        children: <Widget>[
          DecorationPositionView(
            horizontalPosition: horizontalPadding,
            verticalPosition: verticalPadding,
            position: position,
            child: CustomImage(
              imageUrl: imageUrl,
              imagePath: imagePath,
              width: width,
              height: height,
            ),
          ),
          DecorationPositionView(
            child: Visibility(visible: enableOverlay,
              child: AnimatedContainer(
                duration: normalDuration,
                height: height,
                width: width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.2,1],
                    colors: [backgroundColor, backgroundColor.withOpacity(opacity)],
                  ),
                ),
              ),
            ),
            position: position,
            horizontalPosition: 0,
            verticalPosition: 0,
          )
        ],
      ),
    );
  }
  getOpacity(AsyncSnapshot<double> stream){
    if(stream.data <= beginningOpacity) return beginningOpacity;

    return stream.data;
  }
}
