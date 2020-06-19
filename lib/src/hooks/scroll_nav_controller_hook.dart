
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/navigation/utils/nav_bar_controller.dart';


NavBarScrollController useNavController({Function(int index) onTap,SchemeNavigationType navigationType}) => Hook.use(_ControllerHook(navigationType: navigationType,  onTap: (index) => onTap(index)));

class _ControllerHook extends Hook<NavBarScrollController> {
  final Function(int index) onTap;
  final SchemeNavigationType navigationType;
  const _ControllerHook({this.onTap,this.navigationType});

  @override
  _ControllerHookState createState() => _ControllerHookState();
}

class _ControllerHookState
    extends HookState<NavBarScrollController, _ControllerHook> {
  NavBarScrollController  _controller;
   SchemeNavigationType get navigationType => hook.navigationType;
  @override
  void initHook() {
    switch(navigationType){

      case SchemeNavigationType.drawer:
        _controller = NavBarScrollController(navigationType: navigationType);
        break;
      case SchemeNavigationType.top:
        _controller = NavBarScrollController(navigationType: navigationType);
        break;
      case SchemeNavigationType.bottom:
        _controller = NavBarScrollController(navigationType: navigationType)..pageListener(hook.onTap);
        break;
      case SchemeNavigationType.rail:
        _controller = NavBarScrollController(navigationType: navigationType);
        break;
    }


  }

  // Build doesn't return a Widget but rather the ScrollController
  @override
  NavBarScrollController build(BuildContext context) => _controller;

  // This is what we came here for
  @override
  void dispose() =>_controller.dispose();
}
