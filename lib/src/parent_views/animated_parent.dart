import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheme_package/src/decorations/bubble_decoration.dart';
import 'package:scheme_package/src/decorations/custom_wave.dart';
import 'package:scheme_package/src/decorations/logo_decoration.dart';
import 'package:scheme_package/src/global_widgets/custom_bottom_bar.dart';
import 'package:scheme_package/src/ui/animations.dart';
import 'package:scheme_theme/scheme_theme.dart';

enum SlideDirection { Vertical, Horizontal }

class AnimatedBody extends HookWidget {
  final List<Widget> children;
  final double slideOffset;
  final SlideDirection slideDirection;
  final ScrollController scrollController;
  final double topPadding;
  final Color backgroundColor;
  final bool showAppBar;
  final bool enableBack;
  final String appBarTitle;
  final Color collapsedBarColor;
  final Widget trailingWidget;
  final double appBarHeight;
  final TxtStyle barTextStyle;
  final bool showTitle;
  final bool reverseScroll;
  final double paddingBottom;
  final Function onBackPressed;
  final BubbleDecoration bubbleDecoration;
  final LogoDecoration logoDecoration;
  final CustomWaveBackground waveBackground;
  final CustomBottomBar customBottomBar;
  final Widget customBackButton;
  final double animationOffset;
  final bool enableAnimation;
  AnimatedBody(
  {Key key,
    this.scrollController,
      this.children,
      this.slideOffset = 50,
      this.slideDirection = SlideDirection.Vertical,
      this.topPadding,
      this.backgroundColor = background,
      this.showAppBar = false,
      this.enableBack = false,
      this.appBarTitle,
      this.collapsedBarColor = Colors.white,
      this.barTextStyle,
      this.trailingWidget,
      this.appBarHeight,
      this.showTitle = false,
      this.reverseScroll = false,
      this.paddingBottom = 0,
      this.bubbleDecoration,
      this.logoDecoration,
      this.customBottomBar,
      this.onBackPressed,
      this.animationOffset = 72,
      this.waveBackground,
      this.customBackButton,
      this.enableAnimation = true})
      : super(key: key);

  final double scrollOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: normalDuration);
    final animation = useAnimation(colorAnimation(
        controller: animationController, startColor: backgroundColor, endColor: collapsedBarColor));
    final opacityAnimation = useAnimation(Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn))));
    final scaleAnimation = useAnimation(Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn))));

    return Material(
      color: backgroundColor,
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) =>
            handleScrollNotifications(scrollNotification, animationController, scrollOffset),
        child: Stack(
          children: <Widget>[
            if (waveBackground != null) waveBackground,
            if (logoDecoration != null) logoDecoration,
            if (bubbleDecoration != null)
              BubbleDecoration(
                mainBubbleStyle: bubbleDecoration.mainBubbleStyle.clone()
                  ..scale(scaleAnimation)..animate(350,Curves.easeInOut),
                innerBubbleStyle: bubbleDecoration.innerBubbleStyle.clone()
                  ..scale(scaleAnimation)..animate(350,Curves.easeInOut),
                position: bubbleDecoration.position,
              ),
            Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                shrinkWrap: !reverseScroll,
                reverse: reverseScroll,
                controller: scrollController,
                padding: EdgeInsets.only(
                  bottom: paddingBottom,
                  top: topPadding ?? appbarWithPadding + 24,
                ),
                itemCount: animatedList().length,
                itemBuilder: (context, index) {
                  return animatedList()[index];
                },
              ),
            ),
            if (customBottomBar != null)
              AnimatedPositioned(
                duration: normalDuration,
                bottom: 0,
                left: 0,
                right: 0,
                child: customBottomBar,
              ),

            AnimatedPositioned(
                duration: normalDuration,
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                child: Visibility(
                  visible: customBackButton != null,
                  child: customBackButton ?? Container(),
                )),

          ],
        ),
      ),
    );
  }

  animatedList() {
    List<Widget> animatedChildren = List();
    for (Widget child in children) {
      int index = children.indexOf(child);
      animatedChildren.add(animateChild(child, index));
    }
    return animatedChildren;
  }

  animateChild(Widget animatedChild, int index) {
    if (!enableAnimation) return animatedChild;
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: Duration(milliseconds: 375),
      child: sliderChild(animatedChild, slideDirection),
    );
  }

  sliderChild(Widget animatedChild, SlideDirection direction) {
    switch (direction) {
      case SlideDirection.Vertical:
        return verticalSlide(animatedChild);
      case SlideDirection.Horizontal:
        return horizontalSlide(animatedChild);
    }
  }

  verticalSlide(Widget animatedChild) {
    return SlideAnimation(
      verticalOffset: slideOffset,
      child: FadeInAnimation(
        child: animatedChild,
      ),
    );
  }

  horizontalSlide(Widget animatedChild) {
    return SlideAnimation(
      duration: normalDuration,
      horizontalOffset: slideOffset,
      child: FadeInAnimation(
        child: animatedChild,
      ),
    );
  }

  handleScrollNotifications(ScrollNotification scrollNotification,
      AnimationController animationController, double scrollOffset) {
    if (scrollNotification is ScrollUpdateNotification && enableAnimation) {

      if (scrollNotification.metrics.pixels >= animationOffset) {
        animationController.forward();
      }  else if (scrollNotification.metrics.pixels <= 0) {
        animationController.reverse();
      }

      scrollOffset = scrollNotification.metrics.pixels;

    }
    return true;
  }
}
