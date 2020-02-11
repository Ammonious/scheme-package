import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:flutter/material.dart';

import '../../scheme_package.dart';
import 'button_constants.dart';

class ThemeGradientIconButton extends StatelessWidget {
	final Function onTap;
	final IconData icon;
	final double size;
	final List<BoxShadow> boxShadow;
	final double iconSize;
	final Color iconColor;
	final double padding;
	final Color color;
	final LinearGradient gradient;
	ThemeGradientIconButton({
		                        Key key,
		                        this.onTap,
		                        this.size = 50,
		                        this.boxShadow,
		                        this.icon = Boxicons.bxCheck,
		                        this.iconSize = 24,
		                        this.iconColor = nearlyBlack,
		                        this.padding = 0, this.color = Colors.white, this.gradient,
	                        }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return AnimatedContainer(
			duration: normalDuration,
			height: size,
			width: size,
			padding: EdgeInsets.all(padding),
			decoration: superEllipseDecoration(boxShadow,gradient ?? createGradient(color: color)),
			child: Material(
				color: Colors.transparent,
				child: InkWell(
					splashColor: Colors.black.withOpacity(0.4),
					borderRadius: borderRadius,
					onTap: () => onTap(),
					child: Container(
						child: Center(
							child: Icon(
								icon,
								size: iconSize,
								color: iconColor,
							),
						),
					),
				),
			),
		);
	}

	get borderRadius => BorderRadius.only(
			topLeft: Radius.circular(24),
			topRight: Radius.circular(24),
			bottomLeft: Radius.circular(4),
			bottomRight: Radius.circular(24));
}