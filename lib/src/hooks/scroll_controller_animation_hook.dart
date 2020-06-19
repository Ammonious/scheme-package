import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scheme_package/scheme_package.dart';

enum ScrollAnimationType { Directional, Offset }

Animation<double> useScrollAnimation(
        AnimationController animationController, ScrollController scrollController,
        {ScrollAnimationType scrollAnimationType,double offsetBounds = 76}) =>
    Hook.use(_ScrollAnimationHook(
        animationController: animationController, scrollController: scrollController,scrollAnimationType: scrollAnimationType, offsetBounds: offsetBounds));

class _ScrollAnimationHook extends Hook<Animation<double>> {
  final double offsetBounds;
  final AnimationController animationController;
  final ScrollController scrollController;
  final ScrollAnimationType scrollAnimationType;
  const _ScrollAnimationHook({
    @required this.scrollController,
    @required this.animationController,
	                             this.offsetBounds,
    this.scrollAnimationType = ScrollAnimationType.Offset,
  });

  @override
  _ScrollAnimationHookState createState() => _ScrollAnimationHookState();
}

class _ScrollAnimationHookState extends HookState<Animation<double>, _ScrollAnimationHook> {
  Animation _animation;
  ScrollController get _scrollController => hook.scrollController;
  ScrollAnimationType get scrollAnimationType => hook.scrollAnimationType;
  AnimationController get animationController => hook.animationController;
	double  get offsetBounds => hook.offsetBounds;

  @override
  void initHook() {
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    _scrollController.addListener(() {
      switch (scrollAnimationType) {
        case ScrollAnimationType.Directional:
          directionAnimation();
          break;
        case ScrollAnimationType.Offset:
        	offsetAnimation();
          break;
      }
    });
  }

  directionAnimation() {
    switch (_scrollController.position.userScrollDirection) {
      case ScrollDirection.forward:
        animationController.forward();
        break;
      case ScrollDirection.reverse:
        animationController.reverse();
        break;
      case ScrollDirection.idle:
        break;
    }
  }

  offsetAnimation() {
    if (_scrollController.offset >= offsetBounds) {
      animationController.forward();
    } else if (_scrollController.offset <= 0) {
      animationController.reverse();
    }
  }

  // Build doesn't return a Widget but rather the ScrollController
  @override
  Animation<double> build(BuildContext context) => _animation;

  // This is what we came here for
  @override
  void dispose() {

  }
}
