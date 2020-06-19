import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scheme_theme/scheme_theme.dart';

class FadingAppBar extends HookWidget {
  final Color color;
  final List<Widget> options;
  final Widget leading;
  final Widget title;
  final EdgeInsets padding;
  final double height;
  final ScrollController scrollController;
  final Function(double offset) onScroll; 
  final Color iconColor;
  final PublishSubject<double> scrollStream;
  final List<BoxShadow> boxShadow;
  final Widget tabBar;
  final double tabHeight;
  FadingAppBar(    {this.scrollStream,
    Key key,
     this.scrollController,
    this.onScroll,
    this.title,
    this.boxShadow,this.tabBar,
    this.iconColor,
    this.color = Colors.white,this.tabHeight = 0,
    this.options,
    this.leading,
    this.padding,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stream = useStream(scrollStream);
    final opacity = stream != null && stream.hasData ? stream.data : 0.0;
    final isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Material(
        color: Colors.transparent,
        child: AnimatedContainer(
          duration: normalDuration,
          height: height != null ? height + tabHeight : appbarWithPadding + tabHeight,
          padding: padding ?? EdgeInsets.only(top: topPadding),
          decoration: BoxDecoration(
              color: color.withOpacity(opacity != null ? opacity : 0),
              boxShadow: boxShadow ?? <BoxShadow>[
                BoxShadow(
                    color:Colors.black.withOpacity(0.15 * opacity != null ? opacity : 0),
                    offset: Offset(1.1, 1.1),
                    blurRadius: 10.0)
              ]),
          child: Column(
            children: [
              Container(height: kToolbarHeight,
                child: Stack(
                  children: <Widget>[
                    Visibility(visible: leading != null,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: leading != null
                            ? opacity == 1
                            ? filterLeading
                            : leading
                            : Container(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: title != null
                          ? opacity == 1
                          ? Visibility(visible: title != null,
                            child: ColorFiltered(
                        child: title,
                        colorFilter: ColorFilter.mode(color.textColor, BlendMode.srcIn),
                      ),
                          )
                          : title
                          : Container(),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Visibility(visible: options != null,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: options ?? [],
                          ),
                        ))
                  ],
                ),
              ),
              tabBar ?? SizedBox.shrink()
            ],
          ),
        ));
  }




  scrollListener(ValueNotifier opacity) {
    opacity.value = 0.0;
    scrollController.addListener(() {
      if (onScroll != null) onScroll(scrollController.offset);
      if (scrollController.offset >= 75) {
        if (opacity.value < 1.0) opacity.value = 1.0;
      } else if (scrollController.offset <= 75 && scrollController.offset >= 25) {
        if (opacity.value != 0.75)  opacity.value = 0.75;
      } else if (scrollController.offset <= 25) {
        if (opacity.value >= 0.0) opacity.value = 0.0;
      }
    });

  }

 get filterLeading => iconColor != null ? ColorFiltered(
    child: leading,
    colorFilter: ColorFilter.mode(iconColor ?? color.textColor, BlendMode.srcIn),
  ) : leading;
}
