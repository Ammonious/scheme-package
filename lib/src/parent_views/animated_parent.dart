import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/decorations/bubble_decoration.dart';
import 'package:scheme_package/src/decorations/logo_decoration.dart';
import 'package:scheme_package/src/global_widgets/custom_app_bar.dart';
import 'package:scheme_package/src/global_widgets/custom_bottom_bar.dart';
import 'package:scheme_package/src/utils/constants.dart';
import 'package:scheme_package/src/utils/color_tools.dart';

enum SlideDirection { Vertical, Horizontal }

class AnimatedBody extends StatefulWidget {
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
  final Color parentColor;
  final TextStyle appBarStyle;
  final Widget trailingWidget;
  final double appBarHeight;
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
  AnimatedBody(
      {Key key,
      this.children,
      this.slideOffset = 50,
      this.slideDirection = SlideDirection.Vertical,
      this.scrollController,
      this.topPadding,
      this.backgroundColor = background,
      this.showAppBar = false,
      this.enableBack = false,
      this.appBarTitle,
      this.collapsedBarColor = Colors.white,
      this.parentColor = background,
      this.appBarStyle,
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
      this.customBackButton})
      : super(key: key);

  @override
  _AnimatedBodyState createState() => _AnimatedBodyState();
}

class _AnimatedBodyState extends State<AnimatedBody> with TickerProviderStateMixin {
  ScrollController  scrollController = ScrollController();
  AnimationController animationController;
  Animation<double> topBarAnimation;
  Animatable<Color> animateText;

  double topBarOpacity = 0.0;
  double titleOpacity = 0.0;
  double scrollOffset = 0.00;
  double get threshold => widget.animationOffset;


  get waveBackground => widget.waveBackground != null
      ? CustomWaveBackground(
          accentColor: widget.waveBackground.accentColor,
          primaryColor: widget.waveBackground.primaryColor,
          gradient: widget.waveBackground.gradient,
        )
      : null;
  get logoDecoration => widget.logoDecoration != null
      ? LogoDecoration(
          imageUrl: widget.logoDecoration.imageUrl,
          position: widget.logoDecoration.position,
          brandColor: widget.logoDecoration.brandColor,
          enableOverlay: widget.logoDecoration.enableOverlay,
          verticalPadding: widget.logoDecoration.verticalPadding,
          horizontalPadding: widget.logoDecoration.horizontalPadding,
          beginningOpacity: widget.logoDecoration.beginningOpacity,
          height: widget.logoDecoration.height,
          width: widget.logoDecoration.width,
          scrollController: scrollController,
        )
      : null;
  get bubbleDecoration => widget.bubbleDecoration != null
      ? BubbleDecoration(
          mainBubbleSize: widget.bubbleDecoration.mainBubbleSize,
          innerBubbleSize:  widget.bubbleDecoration.innerBubbleSize,
          position: widget.bubbleDecoration.position,
          scrollController: scrollController,
          color: widget.bubbleDecoration.color,
          verticalOffset: widget.bubbleDecoration.verticalOffset,
          delayedDuration: widget.bubbleDecoration.delayedDuration,
          horizontalOffset: widget.bubbleDecoration.horizontalOffset,
        )
      : null;

  get customBottomBar => widget.customBottomBar != null
      ? CustomBottomBar(
          onTapPrimary: () => widget.customBottomBar.onTapPrimary(),
          onTapSecondary: () => widget.customBottomBar.onTapSecondary(),
          primaryTitle: widget.customBottomBar.primaryTitle,
          primaryColor: widget.customBottomBar.primaryColor,
          primaryIcon: widget.customBottomBar.primaryIcon,
          stylePrimary: widget.customBottomBar.stylePrimary,
          styleSecondary: widget.customBottomBar.styleSecondary,
          secondaryEnabled: widget.customBottomBar.secondaryEnabled,
          secondaryColor: widget.customBottomBar.secondaryColor,
          secondaryTitle: widget.customBottomBar.secondaryTitle,
          heroTagPrimary: widget.customBottomBar.heroTagPrimary,
          heroTagSecondary: widget.customBottomBar.heroTagSecondary,
        )
      : null;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    animateText = TweenSequence<Color>(
      [
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(
            begin: widget.parentColor.textColor,
            end:
                widget.collapsedBarColor != null ? widget.collapsedBarColor.textColor : nearlyBlack,
          ),
        ),
      ],
    );
    topBarAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Stack(
        children: <Widget>[
          if (waveBackground != null) waveBackground,
          if (widget.logoDecoration != null) logoDecoration,
          if (bubbleDecoration != null) bubbleDecoration,
          Align(
            alignment: Alignment.topCenter,
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) => handleScrollNotifications(scrollNotification),
              child: ListView.builder(
                shrinkWrap: !widget.reverseScroll,
                reverse: widget.reverseScroll,
                controller: scrollController ?? ScrollController(),
                padding: EdgeInsets.only(
                  bottom: widget.paddingBottom,
                  top: widget.topPadding ?? appbarWithPadding(context) + 24,
                ),
                itemCount: animatedList().length,
                itemBuilder: (context, index) {
                  return animatedList()[index];
                },
              ),
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
            top: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: widget.showAppBar,
              child: CustomAppBar(
                scrollController: scrollController,
                enableBack: widget.enableBack,
                collapsedBarColor: widget.collapsedBarColor,
                title: widget.appBarTitle,
                showTitle: widget.showTitle,
                onBackPressed: () =>
                    widget.onBackPressed != null ? widget.onBackPressed() : Navigator.pop(context),
                opacity: topBarOpacity,
                topBarAnimation: topBarAnimation,
                animationController: animationController,
                animateText: animateText,
              ),
            ),
          ),
          AnimatedPositioned(
              duration: normalDuration,
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              child: Visibility(
                visible: widget.customBackButton != null,
                child: widget.customBackButton ?? Container(),
              )),
        ],
      ),
    );
  }

  animatedList() {
    List<Widget> children = List();
    for (Widget child in widget.children) {
      int index = children.indexOf(child);
      children.add(animateChild(child, index));
    }
    return children;
  }

  animateChild(Widget animatedChild, int index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: Duration(milliseconds: 375),
      child: sliderChild(animatedChild, widget.slideDirection),
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
      verticalOffset: widget.slideOffset,
      child: FadeInAnimation(
        child: animatedChild,
      ),
    );
  }

  horizontalSlide(Widget animatedChild) {
    return SlideAnimation(
      duration: normalDuration,
      horizontalOffset: widget.slideOffset,
      child: FadeInAnimation(
        child: animatedChild,
      ),
    );
  }

  handleScrollNotifications(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollUpdateNotification) {
      setState(() {
        scrollOffset = scrollNotification.metrics.pixels;
      });
      scrollOffset = scrollNotification.metrics.pixels;
      if (widget.showAppBar) {
        notificationListener(scrollNotification.metrics.pixels);
      }
    }
    return true;
  }

  notificationListener(double offset) {
    if (offset >= threshold) {
      if (topBarOpacity != 1.0) {
        setState(() {
          topBarOpacity = 1.0;
        });
      }
    } else if (offset <= threshold && offset >= 0) {
      if (topBarOpacity != offset / threshold) {
        setState(() {
          topBarOpacity = offset / threshold;
        });
      }
    } else if (offset <= 0) {
      if (topBarOpacity != 0.0) {
        setState(() {
          topBarOpacity = 0.0;
        });
      }
    }

  }


}
