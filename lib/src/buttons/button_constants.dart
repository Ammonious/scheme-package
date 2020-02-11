import 'package:flutter/material.dart';
import 'package:scheme_package/src/decorations/superellipse_shape.dart';
import 'package:scheme_package/src/utils/constants.dart';

ShapeDecoration superEllipseDecoration(List<BoxShadow> boxShadow, LinearGradient gradient) =>
		ShapeDecoration(
			gradient: gradient,
			shadows: boxShadow ?? liftedShadow,
			shape: SuperellipseShape(
				borderRadius: BorderRadius.circular(28.0),
			),
		);

BoxDecoration regularThemeDecoration(
		List<BoxShadow> boxShadow, LinearGradient gradient, BorderRadius borderRadius) =>
		BoxDecoration(boxShadow: boxShadow, gradient: gradient, borderRadius: borderRadius);

ShapeDecoration superEllipseOutline(double borderWidth, Color borderColor) => ShapeDecoration(
	shape: SuperellipseShape(
		side: BorderSide(width: borderWidth, color: borderColor),
		borderRadius: BorderRadius.circular(28.0),
	),
);

BoxDecoration regularOutline(double borderWidth, Color borderColor) => BoxDecoration(
		border: Border.all(color: borderColor, width: borderWidth),
		borderRadius: BorderRadius.circular(12));
