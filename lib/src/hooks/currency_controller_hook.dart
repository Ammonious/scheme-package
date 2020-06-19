import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scheme_package/scheme_package.dart';

/// - [TextEditingController], which this hook creates.
CurrencyTextFieldController useCurrencyTextFieldController() => Hook.use(_CurrencyTextFieldControllerHook());

class _CurrencyTextFieldControllerHook extends Hook<CurrencyTextFieldController> {

	_CurrencyTextFieldControllerHook();

	@override
	_CurrencyTextFieldControllerHookState createState() {
		return _CurrencyTextFieldControllerHookState();
	}
}

class _CurrencyTextFieldControllerHookState
		extends HookState<CurrencyTextFieldController, _CurrencyTextFieldControllerHook> {
	CurrencyTextFieldController _controller;

	@override
	void initHook() {
		_controller = CurrencyTextFieldController();
	}

	@override
	CurrencyTextFieldController build(BuildContext context) => _controller;

	@override
	void dispose() => _controller?.dispose();
}

