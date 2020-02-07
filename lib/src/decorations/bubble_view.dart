
import 'package:flutter/material.dart';
import 'package:scheme_package/src/utils/color_tools.dart';

import 'bubble_decoration.dart';
import 'decoration_positioner.dart';

class BubbleView extends StatelessWidget {
	final double size;
	final double padding;
	final BubblePosition position;
	final double hPadding;
	final double vPadding;
	final Color color;
	BubbleView({
		           Key key,
		           this.size,
		           this.padding,
		           this.position,
		           this.hPadding,
		           this.vPadding, this.color = Colors.blue,
	           }) : super(key: key);

	@override
	Widget build(BuildContext context) {
	return	DecorationPositionView(position: position,child: bubble,verticalPosition: vPadding,horizontalPosition: hPadding,);
	}


	get bubble => AnimatedContainer(
		duration: Duration(milliseconds: 350),
		width: size,
		height: size,
		decoration: BoxDecoration(
				shape: BoxShape.circle,
				gradient: LinearGradient(colors: [
					color.shade500,
					color.shade700
				]),
				boxShadow: [
					BoxShadow(color: color.shade700, offset: Offset(4.0, 4.0), blurRadius: 10.0)
				]),
	);
}
