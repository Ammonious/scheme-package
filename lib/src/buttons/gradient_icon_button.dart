import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scheme_theme/scheme_theme.dart';

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
	final BorderRadius borderRadius;
	final bool enabled;
	ThemeGradientIconButton({
		                        Key key,
		                        this.onTap,
		                        this.size = 50,
		                        this.boxShadow,
		                        this.icon = Boxicons.bxCheck,
		                        this.iconSize = 24,
		                        this.iconColor = nearlyBlack,
		                        this.padding = 0, this.color = Colors.white, this.gradient, this.borderRadius,this.enabled = true
	                        }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Padding(padding: EdgeInsets.all(kIsWeb ? 4 : 0),
		  child: AnimatedContainer(
		  	duration: normalDuration,
		  	height: size,
		  	width: size,
		  	padding: EdgeInsets.all(padding),
		  	decoration: superEllipseDecoration(boxShadow,gradient ?? schemeGradient(color: color),borderRadius),
		  	child: Material(
		  		color: Colors.transparent,
		  		child: InkWell(
		  			splashColor: Colors.black.withOpacity(0.4),
		  			borderRadius: borderRadius ?? BorderRadius.circular(28),
		  			onTap: () => onTap != null && enabled ? onTap() : null,
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
		  ),
		);
	}


}