import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scheme_package/scheme_package.dart';

import 'base_nav_controller.dart';

class NavBarScrollController extends NavBarController {
  NavBarScrollController({
    ScrollController scrollController,
    SchemeNavigationType navigationType,
    bool snap = true,
  }) : super(scrollController: scrollController, snap: snap,navigationType: navigationType ?? SchemeNavigationType.top);

  @override
  double getHeight(SchemeNavigationType type) {
    // TODO: implement getHeight
    return navigationType == SchemeNavigationType.top ? kToolbarHeight : kBottomNavigationBarHeight;
  }
  @override
  double height;

  final _page$ = BehaviorSubject<int>.seeded(0);

  @Deprecated("pageListener method should been used instead")
  Stream<int> get stream => pageStream;

  Stream<int> get pageStream => _page$.stream;

  void changePage(int index) => _page$.add(index);

  StreamSubscription<int> pageListener(
      void Function(int) onData, {
        Function onError,
        void Function() onDone,
        bool cancelOnError,
      }) {
    return _page$.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}