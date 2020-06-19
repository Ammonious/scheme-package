import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';




ScrollController useScrollController({bool keepScrollOffset}) => Hook.use(_ScrollControllerHook(keepScrollOffset: keepScrollOffset));

class _ScrollControllerHook extends Hook<ScrollController> {
	final bool keepScrollOffset;
	const _ScrollControllerHook({this.keepScrollOffset});

	@override
	ScrollControllerHookState createState() => ScrollControllerHookState();
}

class ScrollControllerHookState
		extends HookState<ScrollController, _ScrollControllerHook> {
	ScrollController  _scrollController;
	bool get keepScrollOffset => hook.keepScrollOffset ?? false;
	@override
	void initHook() {
		_scrollController = ScrollController(keepScrollOffset: keepScrollOffset);

	}

	// Build doesn't return a Widget but rather the ScrollController
	@override
	ScrollController build(BuildContext context) => _scrollController;

	// This is what we came here for
	@override
	void dispose() =>_scrollController.dispose();
}