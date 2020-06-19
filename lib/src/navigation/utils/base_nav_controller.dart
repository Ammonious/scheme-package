
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scheme_package/scheme_package.dart';

abstract class NavBarController {
  NavBarController ({this.scrollController, bool snap = true,SchemeNavigationType navigationType,}) {
    _snap = snap;
    _type = navigationType;
    (scrollController ??= ScrollController()).addListener(_scrollListener);
  }
  SchemeNavigationType _type;
  bool _snap;
  double getHeight(SchemeNavigationType type);
  double get height => getHeight(navigationType);
  ScrollController scrollController;

  // ==========================================
  // heightFactory$
  // ==========================================

  final _heightFactor$ = BehaviorSubject<double>.seeded(1.0);

  Stream<double> get heightFactorStream => _heightFactor$.stream;

  double _delta = 0.0, _oldOffset = 0.0;

  void _scrollListener() {
    setSnapState(snap);

    ScrollPosition position = scrollController.position;
    double pixels = position.pixels;

    _delta = (_delta + pixels - _oldOffset).clamp(0.0, height);
    _oldOffset = pixels;

    if (position.axisDirection == AxisDirection.down &&
        position.extentAfter == 0.0) {
      if (_heightFactor$.stream.value == 0.0) return;
      return _heightFactor$.add(0.0);
    }

    if (position.axisDirection == AxisDirection.up &&
        position.extentBefore == 0.0) {
      if (_heightFactor$.stream.value == 1.0) return;
      return _heightFactor$.add(1.0);
    }

    if ((_delta == 0.0 && _heightFactor$.stream.value == 0.0) ||
        (_delta == height && _heightFactor$.stream.value == 1.0)) return;

    _heightFactor$.add(1.0 - _delta / height);
  }

  void _isScrollingNotifier() {
    if (scrollController.position.isScrollingNotifier.value) return;

    double limit = (1.0 - _delta / height).roundToDouble();

    if (_heightFactor$.stream.value == limit) return;

    _heightFactor$.add(limit);
  }

  bool get snap => _snap;
  
  SchemeNavigationType get navigationType => _type;

  void toggleSnap() => setSnapState(!_snap);

  void setSnapState(bool snap) {
    _snap = snap;
    if (_snap) {
      if (scrollController.position.isScrollingNotifier.hasListeners) return;
      scrollController.position.isScrollingNotifier
          .addListener(_isScrollingNotifier);
    } else {
      scrollController.position.isScrollingNotifier
          .removeListener(_isScrollingNotifier);
    }
  }

  // ==========================================
  // pin$
  // ==========================================

  final _pin$ = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get pinStream => _pin$.stream;

  bool get isPinned => _pin$.value;

  void setPinState(bool pin) => _pin$.add(pin);

  void togglePin() => setPinState(!_pin$.value);

  // ==========================================
  // Dispose
  // ==========================================

  void dispose() {
    _pin$.close();
    _heightFactor$.close();
     
  }
}