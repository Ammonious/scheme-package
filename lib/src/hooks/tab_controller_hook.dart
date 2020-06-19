import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

TabController useTabController({int pages,TickerProvider tickerProvider}) => Hook.use(_TabControllerHook(pages: pages,tickerProvider: tickerProvider));

class _TabControllerHook extends Hook<TabController> {
  final int pages;
  final TickerProvider tickerProvider;
  const _TabControllerHook({this.pages = 0,@required this.tickerProvider});

  @override
  TabControllerHookState createState() => TabControllerHookState();
}

class TabControllerHookState extends HookState<TabController, _TabControllerHook> {
  TabController _controller;

  @override
  void initHook() {
    _controller = TabController(vsync: hook.tickerProvider, initialIndex: 0, length: hook.pages);
  }

  // Build doesn't return a Widget but rather the ScrollController
  @override
  TabController build(BuildContext context) => _controller;

  // This is what we came here for
  @override
  void dispose() => _controller.dispose();
}
