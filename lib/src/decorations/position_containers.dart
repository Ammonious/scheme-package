

import 'package:flutter/material.dart';
import 'package:scheme_theme/scheme_theme.dart';

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

class BottomCenterPosition extends StatelessWidget {
	final	double hPadding;
	final double vPadding;
	final Widget child;
	BottomCenterPosition({Key key, this.hPadding = -100, this.vPadding = -150, this.child}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return AnimatedAlign(
			duration: normalDuration,
			alignment: Alignment.bottomCenter,
			child:Padding(
				padding: EdgeInsets.symmetric(vertical: -vPadding),
				child: child,
			),
		);
	}
}

class TopCenterPosition extends StatelessWidget {
	final	double hPadding;
	final double vPadding;
	final Widget child;
	TopCenterPosition({Key key, this.hPadding = -100, this.vPadding = -150, this.child}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return AnimatedAlign(
			duration: normalDuration,
			alignment: Alignment.topCenter,
			child: Padding(
			  padding: EdgeInsets.symmetric(vertical: vPadding),
			  child: child,
			),
		);
	}
}