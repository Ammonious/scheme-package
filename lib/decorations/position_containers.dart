

import 'package:flutter/material.dart';
import 'package:scheme_package/utils/constants.dart';

class TopRightPosition extends StatelessWidget {
	final	double hPadding;
	final double vPadding;
	final Widget child;
	TopRightPosition({Key key, this.hPadding = -100, this.vPadding = -150, this.child}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return AnimatedPositioned(
			duration: normalDuration,
			right:hPadding,
			top:vPadding,
			child: child,
		);
	}
}

class TopLeftPosition extends StatelessWidget {
	final	double hPadding;
	final double vPadding;
	final Widget child;
	TopLeftPosition({Key key, this.hPadding = -100, this.vPadding = -150, this.child}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return AnimatedPositioned(
			duration: normalDuration,
			left:hPadding,
			top:vPadding,
			child: child,
		);
	}
}

class BottomRightPosition extends StatelessWidget {
	final	double hPadding;
	final double vPadding;
	final Widget child;
	BottomRightPosition({Key key, this.hPadding = -100, this.vPadding = -150, this.child}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return AnimatedPositioned(
			duration: normalDuration,
			right:hPadding,
			bottom:vPadding,
			child: child,
		);
	}
}

class BottomLeftPosition extends StatelessWidget {
	final	double hPadding;
	final double vPadding;
	final Widget child;
	BottomLeftPosition({Key key, this.hPadding = -100, this.vPadding = -150, this.child}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return AnimatedPositioned(
			duration: normalDuration,
			left:hPadding,
			bottom: vPadding,
			child: child,
		);
	}
}