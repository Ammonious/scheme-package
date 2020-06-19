import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';



PageController usePageController({int initialPage}) => Hook.use(_PageControllerHook(initialPage: initialPage));

class _PageControllerHook extends Hook<PageController> {
	final int initialPage;
	const _PageControllerHook({this.initialPage});

	@override
	PageControllerHookState createState() => PageControllerHookState();
}

class PageControllerHookState
		extends HookState<PageController, _PageControllerHook> {
	PageController  _controller;

	@override
	void initHook() {
		_controller = PageController(initialPage: hook.initialPage ?? 0);

	}

	// Build doesn't return a Widget but rather the ScrollController
	@override
	PageController build(BuildContext context) => _controller;

	// This is what we came here for
	@override
	void dispose() => _controller.dispose();
}