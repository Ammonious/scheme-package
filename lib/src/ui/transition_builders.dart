import 'package:flutter/material.dart';

enum TransitionTypes {
  SlideRight,
  SlideLeft,
  SlideTop,
  SlideBottom,
  SlideTopFade,
  SlideBottomFade,
  SlideRightFade,
  SlideLeftFade,
  FadeIn,
	ZoomIn,
}

  initTransitionType(TransitionTypes type) {
  switch (type) {
    case TransitionTypes.SlideRight:
      return slideRight;
    case TransitionTypes.SlideLeft:
      return slideLeft;
    case TransitionTypes.SlideTop:
      return slideTop;
    case TransitionTypes.SlideBottom:
      return slideBottom;
    case TransitionTypes.SlideTopFade:
      return slideTopWithFade;
    case TransitionTypes.SlideBottomFade:
      return slideBottomWithFade;
    case TransitionTypes.SlideRightFade:
      return slideRightWithFade;
    case TransitionTypes.SlideLeftFade:
      return slideLeftWithFade;
    case TransitionTypes.FadeIn:
      return fadeIn;
	  case TransitionTypes.ZoomIn:
	  	return zoomIn;
	  default: return fadeIn;
  }
}

const RouteTransitionsBuilder slideRight = _slideRight;

Widget _slideRight(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn))),
    child: child,
  );
}

const RouteTransitionsBuilder slideLeft = _slideLeft;

Widget _slideLeft(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn))),
    child: child,
  );
}

const RouteTransitionsBuilder slideRightWithFade = _slideRightWithFade;

Widget _slideRightWithFade(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn))),
    child: FadeTransition(opacity: animation, child: child),
  );
}

const RouteTransitionsBuilder slideLeftWithFade = _slideLeftWithFade;

Widget _slideLeftWithFade(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn))),
    child: FadeTransition(opacity: animation, child: child),
  );
}

const RouteTransitionsBuilder slideTop = _slideTop;

Widget _slideTop(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn))),
    child: child,
  );
}

const RouteTransitionsBuilder slideBottom = _slideBottom;

Widget _slideBottom(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,

    ).animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn))),
    child: child,
  );
}

const RouteTransitionsBuilder slideBottomWithFade = _slideBottomWithFade;

Widget _slideBottomWithFade(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn))),
    child: FadeTransition(opacity: animation, child: child),
  );
}

const RouteTransitionsBuilder slideTopWithFade = _slideTopWithFade;

Widget _slideTopWithFade(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn))),
    child: FadeTransition(opacity: animation, child: child),
  );
}

const RouteTransitionsBuilder fadeIn = _fadeIn;

Widget _fadeIn(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(opacity: animation, child: child);
}

const RouteTransitionsBuilder zoomIn = _zoomIn;

Widget _zoomIn(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return ScaleTransition(scale: animation, child: child);
}
