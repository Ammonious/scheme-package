import 'package:flutter/material.dart';

import '../../scheme_package.dart';
import 'button_constants.dart';

class ThemeOutlineButton extends StatelessWidget {
	final Function onTap;
	final String buttonTitle;
	final double height;
	final double width;
	final double borderWidth;
	final Color borderColor;
	final TextStyle textStyle;
	final bool superellipseShape;

	const ThemeOutlineButton({
		                         Key key,
		                         this.onTap,
		                         this.buttonTitle = '',
		                         this.height = 50,
		                         this.width = 200,
		                         this.textStyle,
		                         this.superellipseShape = false,
		                         this.borderWidth = 2,
		                         this.borderColor = Colors.grey,
	                         }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Container(
			height: height,
			width: width,
			padding: EdgeInsets.only(left: 8, right: 8),
			decoration: superellipseShape
					? superEllipseOutline(borderWidth, borderColor)
					: regularOutline(borderWidth, borderColor),
			child: Material(
				color: Colors.transparent,
				child: InkWell(
					splashColor: Colors.white.withOpacity(0.4),
					borderRadius: BorderRadius.circular(12),
					onTap: () {
						onTap();
					},
					child: Container(
						child: Center(
							child: SmartText(text:
							buttonTitle,
								maxLines: 1,
								style: textStyle == null
										? button
										: textStyle,
							),
						),
					),
				),
			),
		);
	}
}