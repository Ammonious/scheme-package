import 'package:flutter/material.dart';

import '../../scheme_package.dart';
import 'button_constants.dart';

class GradientButton extends StatelessWidget {
	final Function onTap;
	final String buttonTitle;
	final double height;
	final double width;
	final TextStyle textStyle;
	final List<BoxShadow> boxShadow;
	final bool superellipseShape;
	final IconData iconData;
	final Color color;
	final LinearGradient gradient;
	final double iconSize;
	final BorderRadius borderRadius;
	const GradientButton({
		                     Key key,
		                     this.onTap,
		                     this.buttonTitle = '',
		                     this.height = 50,
		                     this.width = 200,
		                     this.textStyle,
		                     this.boxShadow,
		                     this.superellipseShape = false,
		                     this.color = Colors.white,
		                     this.iconData,
		                     this.iconSize = 24,
		                     this.borderRadius, this.gradient,
	                     }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Container(
			height: height,
			width: width,
			decoration: superellipseShape
					? superEllipseDecoration(boxShadow,gradient ?? createGradient(color: color))
					: regularThemeDecoration(boxShadow,gradient ??  createGradient(color: color),
					borderRadius ?? BorderRadius.circular(12)),
			child: Material(
				color: Colors.transparent,
				child: InkWell(
					splashColor: Colors.white.withOpacity(0.4),
					borderRadius: borderRadius ?? BorderRadius.circular(12),
					onTap: () {
						if (onTap != null) onTap();
					},
					child: Container(
						padding: EdgeInsets.only(left: 8, right: 8),
						child: Center(
								child: Row(
									mainAxisAlignment: MainAxisAlignment.center,
									children: <Widget>[
										Visibility(
											visible: iconData != null,
											child: Container(
												margin: EdgeInsets.only(right: 14),
												child: Icon(
													iconData,
													size: iconSize,
													color: color.shade600.textColor,
												),
											),
										),
										SmartText(text:
										buttonTitle,
											backgroundColor:gradient != null ? gradient.colors[1] : color.shade700,
											maxLines: 1,
											style: textStyle == null
													? button
													: textStyle,
										),
									],
								)),
					),
				),
			),
		);
	}
}
