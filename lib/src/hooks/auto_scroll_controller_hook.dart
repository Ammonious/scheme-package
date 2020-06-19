import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scheme_package/src/scrolling/scroll_to_index.dart';

AutoScrollController useAutoScrollController({Axis scrollDirection,bool keepScrollOffset,ViewportBoundaryGetter viewportBoundaryGetter}) => Hook.use(_AutoScrollControllerHook(scrollDirection: scrollDirection,keepScrollOffset: keepScrollOffset,viewportBoundaryGetter:viewportBoundaryGetter));

class _AutoScrollControllerHook extends Hook<AutoScrollController> {
  final Axis scrollDirection;
  final bool keepScrollOffset;
  final ViewportBoundaryGetter viewportBoundaryGetter;
  const _AutoScrollControllerHook({this.keepScrollOffset,this.scrollDirection,this.viewportBoundaryGetter,});

  @override
  AutoScrollControllerHookState createState() => AutoScrollControllerHookState();
}

class AutoScrollControllerHookState
    extends HookState<AutoScrollController, _AutoScrollControllerHook> {
  AutoScrollController  _controller;
  Axis get scrollDirection => hook.scrollDirection;
  bool get keepScrollOffset => hook.keepScrollOffset ?? false;
  ViewportBoundaryGetter get viewportBoundaryGetter => hook.viewportBoundaryGetter;
  @override
  void initHook() {
    _controller = AutoScrollController(
        axis:scrollDirection,
        keepScrollOffset: keepScrollOffset,
        viewportBoundaryGetter: viewportBoundaryGetter ?? () =>   Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom));

  }

  // Build doesn't return a Widget but rather the ScrollController
  @override
  AutoScrollController build(BuildContext context) => _controller;

  // This is what we came here for
  @override
  void dispose() =>_controller.dispose();
}