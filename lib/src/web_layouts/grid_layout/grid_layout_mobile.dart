import 'package:flutter/material.dart';
import 'package:scheme_package/src/web_layouts/decoration_view_model.dart';
import 'package:scheme_package/src/web_layouts/full_base_layout.dart';
import 'package:scheme_package/src/web_layouts/relative_height_base_layout.dart';

import '../web_constants.dart';

class GridLayoutMobile extends StatelessWidget {
	final List<Widget> children;
	final List<Widget> decorations;
	final BaseLayoutType baseLayoutType;
	final Color backgroundColor;
	final CrossAxisAlignment crossAxisAlignment;
	final MainAxisAlignment mainAxisAlignment;
	final Alignment alignment;
	final double maxWidth;
	final LinearGradient gradient;
	final String backgroundImage;
	final EdgeInsets padding;
	GridLayoutMobile({
		                  Key key,
		                  this.baseLayoutType,
		                  this.backgroundColor = Colors.white,
		                  this.decorations,
		                 this.crossAxisAlignment = CrossAxisAlignment.center,
		                 this.mainAxisAlignment = MainAxisAlignment.spaceAround,
		                 this.alignment = Alignment.topCenter,
		                 this.children,
		                    this.maxWidth, this.gradient, this.backgroundImage, this.padding,
	                  }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		switch (baseLayoutType) {
			case BaseLayoutType.Full:
				return fullLayout(context);
			case BaseLayoutType.Relative:
				return relativeLayout(context);
			default:
				return  relativeLayout(context);
		}
	}

	fullLayout(BuildContext context) => FullBaseLayout(backgroundImage: backgroundImage,backgroundColor: backgroundColor,gradient: gradient,
		child: Container(
			padding: EdgeInsets.only(left: 16, right: 16),
			child: Stack(
				fit: StackFit.expand,
				children: gridChildren(
						decorations: decorations,
						children: children,
					padding: padding,
						crossAxisAlignment: crossAxisAlignment,
						mainAxisAlignment: mainAxisAlignment,
				),
			),
		),
	);

	relativeLayout(BuildContext context) => RelativeBaseLayout(
		child: Container(
			padding: EdgeInsets.only(left: 16, right: 16),
			decoration: BoxDecoration(color: backgroundColor),
			child: Stack(
				alignment: alignment,
				fit: StackFit.expand,
				children: gridChildren(
						decorations: decorations,
					padding: padding,
						children: children,
						crossAxisAlignment: crossAxisAlignment,
						mainAxisAlignment: mainAxisAlignment, ),
			),
		),
	);
}
