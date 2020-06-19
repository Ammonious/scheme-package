import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scheme_package/src/global_widgets/expandable_panel.dart';


ExpandableController useExpandableController({bool initialExpanded,Duration animationDuration,int index}) => Hook.use(_ExpandableControllerHook(initialExpanded: initialExpanded,animationDuration: animationDuration,index:index ));

class _ExpandableControllerHook extends Hook<ExpandableController> {
	final bool initialExpanded;
	final Duration animationDuration;
	final int index;
	const _ExpandableControllerHook({this.initialExpanded = false,this.animationDuration,this.index});

	@override
	ExpandableControllerHookState createState() => ExpandableControllerHookState();
}

class ExpandableControllerHookState extends HookState<ExpandableController, _ExpandableControllerHook> {
	ExpandableController _controller;
	Duration animationDuration;
	bool initialExpanded;
	int get index => hook.index ?? 0;
	@override
	void initHook() {
	animationDuration =  hook.animationDuration ??	Duration(milliseconds: 350);
	initialExpanded = hook.initialExpanded ?? false;
		_controller = ExpandableController(initialExpanded: initialExpanded,animationDuration: animationDuration);


	}

	@override
	ExpandableController build(BuildContext context) => _controller;

	// This is what we came here for
	@override
	void dispose(){
		_controller?.dispose();
	}
}