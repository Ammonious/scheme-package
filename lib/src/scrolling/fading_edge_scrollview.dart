import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Flutter widget for displaying fading edge at start/end of scroll views
class FadingEdgeScrollView extends StatefulWidget {
  /// child widget
  final Widget child;

  /// The [Color] to which it fades. Default [Colors.white] ;
  ///
  ///
  final Color fadeColor;


  final Function(double offset) onScroll;

  /// scroll controller of child widget
  ///
  /// Look for more documentation at [ScrollView.scrollController]
  final ScrollController scrollController;

  /// Whether the scroll view scrolls in the reading direction.
  ///
  /// Look for more documentation at [ScrollView.reverse]
  final bool reverse;

  /// The axis along which child view scrolls
  ///
  /// Look for more documentation at [ScrollView.scrollDirection]
  final Axis scrollDirection;

  /// what part of screen on start half should be covered by fading edge gradient
  /// [gradientFractionOnStart] must be 0 <= [gradientFractionOnStart] <= 1
  /// 0 means no gradient,
  /// 1 means gradients on start half of widget fully covers it
  final double gradientFractionOnStart;

  /// what part of screen on end half should be covered by fading edge gradient
  /// [gradientFractionOnEnd] must be 0 <= [gradientFractionOnEnd] <= 1
  /// 0 means no gradient,
  /// 1 means gradients on start half of widget fully covers it
  final double gradientFractionOnEnd;

  const FadingEdgeScrollView._internal({
    Key key,
    @required this.child,
    @required this.scrollController,
    @required this.reverse,
    @required this.scrollDirection,
    @required this.gradientFractionOnStart,
    @required this.gradientFractionOnEnd,
    this.fadeColor = Colors.white, this.onScroll,
  })
      : assert(child != null),
        assert(scrollController != null),
        assert(reverse != null),
        assert(scrollDirection != null),
        assert(gradientFractionOnStart >= 0 && gradientFractionOnStart <= 1),
        assert(gradientFractionOnEnd >= 0 && gradientFractionOnEnd <= 1),
        super(key: key);

  /// Constructor for creating [FadingEdgeScrollView] with [ScrollView] as child
  /// child must have [ScrollView.controller] set
  factory FadingEdgeScrollView.fromScrollView({
    Key key,
    @required ScrollView child,
    double gradientFractionOnStart = 0.1,
    double gradientFractionOnEnd = 0.1,
    Color fadeColor = Colors.white,
    Widget Function(double offset) builder,
		Function(double offset) onScroll,
  }) {
    assert(child.controller != null, "Child must have controller set");

    return FadingEdgeScrollView._internal(
      key: key,
      child: child,
      scrollController: child.controller,
      scrollDirection: child.scrollDirection,
      reverse: child.reverse,
      gradientFractionOnStart: gradientFractionOnStart,
      gradientFractionOnEnd: gradientFractionOnEnd,
      fadeColor: fadeColor, onScroll:onScroll
    );
  }

  /// Constructor for creating [FadingEdgeScrollView] with [SingleChildScrollView] as child
  /// child must have [SingleChildScrollView.controller] set
  factory FadingEdgeScrollView.fromSingleChildScrollView({Key key,
    @required SingleChildScrollView child,
    double gradientFractionOnStart = 0.1,
    double gradientFractionOnEnd = 0.1,
    Color fadeColor = Colors.white,
		Function(double offset) onScroll, }) {
    assert(child.controller != null, "Child must have controller set");

    return FadingEdgeScrollView._internal(
      key: key,
      child: child,
      scrollController: child.controller,
      scrollDirection: child.scrollDirection,
      reverse: child.reverse,
      gradientFractionOnStart: gradientFractionOnStart,
      gradientFractionOnEnd: gradientFractionOnEnd,
      fadeColor: fadeColor, onScroll: onScroll,
    );
  }

  /// Constructor for creating [FadingEdgeScrollView] with [PageView] as child
  /// child must have [PageView.controller] set
  factory FadingEdgeScrollView.fromPageView({
    Key key,
    @required PageView child,
    double gradientFractionOnStart = 0.1,
    double gradientFractionOnEnd = 0.1,
    Color fadeColor = Colors.white,
		Function(double offset) onScroll,
  }) {
    assert(child.controller != null, "Child must have controller set");

    return FadingEdgeScrollView._internal(
      key: key,
      child: child,
      scrollController: child.controller,
      scrollDirection: child.scrollDirection,
      reverse: child.reverse,
      gradientFractionOnStart: gradientFractionOnStart,
      gradientFractionOnEnd: gradientFractionOnEnd,
      fadeColor: fadeColor,
			onScroll: onScroll,
    );
  }

  /// Constructor for creating [FadingEdgeScrollView] with [AnimatedList] as child
  /// child must have [AnimatedList.controller] set
  factory FadingEdgeScrollView.fromAnimatedList({
    Key key,
    @required AnimatedList child,
    double gradientFractionOnStart = 0.1,
    double gradientFractionOnEnd = 0.1,
    Color fadeColor = Colors.white,
		Function(double offset) onScroll,
  }) {
    assert(child.controller != null, "Child must have controller set");

    return FadingEdgeScrollView._internal(
      key: key,
      child: child,
      scrollController: child.controller,
      scrollDirection: child.scrollDirection,
      reverse: child.reverse,
      gradientFractionOnStart: gradientFractionOnStart,
      gradientFractionOnEnd: gradientFractionOnEnd,
      fadeColor: fadeColor,
			onScroll: onScroll,
    );
  }

  @override
  _FadingEdgeScrollViewState createState() => _FadingEdgeScrollViewState();
}

class _FadingEdgeScrollViewState extends State<FadingEdgeScrollView> {
  ScrollController _controller;
  bool _isScrolledToStart;
  bool _isScrolledToEnd = false;
	double scrollOffset = 0.0;
  @override
  void initState() {
    super.initState();
    _controller = widget.scrollController;
    _isScrolledToStart = _controller.initialScrollOffset == 0;
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller?.removeListener(_onScroll);
  }

  void _onScroll() {
    final offset = _controller.offset;
    final minOffset = _controller.position.minScrollExtent;
    final maxOffset = _controller.position.maxScrollExtent;
    setState(() {
      scrollOffset = offset;
    });
    final isScrolledToEnd = offset >= maxOffset;
    final isScrolledToStart = offset <= minOffset;
		if(widget.onScroll != null) widget.onScroll(offset);
    if (isScrolledToEnd != _isScrolledToEnd ||
        isScrolledToStart != _isScrolledToStart) {
      setState(() {
        _isScrolledToEnd = isScrolledToEnd;
        _isScrolledToStart = isScrolledToStart;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isScrolledToStart == null && _controller.hasClients) {
      final offset = _controller.offset;
      final minOffset = _controller.position.minScrollExtent;
      final maxOffset = _controller.position.maxScrollExtent;

      _isScrolledToEnd = offset >= maxOffset;
      _isScrolledToStart = offset <= minOffset;
    }
    return !kIsWeb
        ? ShaderMask(
      shaderCallback: (bounds) =>
          LinearGradient(
            begin: _gradientStart,
            end: _gradientEnd,
            stops: [
              0,
              widget.gradientFractionOnStart * 0.5,
              1 - widget.gradientFractionOnEnd * 0.7,
              1,
            ],
            colors: _getColors(
                widget.gradientFractionOnStart > 0 &&
                    !(_isScrolledToStart ?? true),
                widget.gradientFractionOnEnd > 0 &&
                    !(_isScrolledToEnd ?? false),
                widget.fadeColor),
          ).createShader(bounds.shift(Offset(-bounds.left, -bounds.top))),
      child: widget.child,
      blendMode: BlendMode.dstIn,
    ) : widget.child;
  }

  Alignment get _gradientStart =>
      widget.scrollDirection == Axis.vertical
          ? _verticalStart
          : _horizontalStart;

  Alignment get _gradientEnd =>
      widget.scrollDirection == Axis.vertical ? _verticalEnd : _horizontalEnd;

  Alignment get _verticalStart =>
      widget.reverse ? Alignment.bottomCenter : Alignment.topCenter;

  Alignment get _verticalEnd =>
      widget.reverse ? Alignment.topCenter : Alignment.bottomCenter;

  Alignment get _horizontalStart =>
      widget.reverse ? Alignment.centerRight : Alignment.centerLeft;

  Alignment get _horizontalEnd =>
      widget.reverse ? Alignment.centerLeft : Alignment.centerRight;

  List<Color> _getColors(bool isStartEnabled, bool isEndEnabled, Color color) =>
      [
        (isStartEnabled ? Colors.transparent : Colors.white),
        color,
        color,
        (isEndEnabled ? Colors.transparent : Colors.white)
      ];


}
