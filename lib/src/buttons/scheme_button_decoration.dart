import 'package:flutter/material.dart';
import 'package:scheme_theme/scheme_theme.dart';

class SchemeButtonDecoration {

	final bool superEllipseShape;
	final BorderRadius borderRadius;
	final double borderWidth;
	final Color borderColor;
	final List<BoxShadow> boxShadow;

  SchemeButtonDecoration( {this.boxShadow , this.borderRadius, this.borderWidth = 2, this.borderColor = Colors
		  .grey, this.superEllipseShape = false,});


  factory SchemeButtonDecoration.defaultValue() =>  SchemeButtonDecoration(borderColor: Colors.grey,boxShadow: flatShadow,borderRadius: BorderRadius.circular(0),borderWidth: 2,superEllipseShape: false);

}