
import 'package:clay_containers/clay_containers.dart' hide CurveType;
import 'package:flutter/material.dart';
import 'neu_inner_shadow.dart';
class NeumorphicContainer extends StatelessWidget {
	NeumorphicContainer({
		                    this.child,
		                    this.bevel = 12.0,
		                    this.curveType = NeuCurveType.concave,
		                    Color color,
		                    NeumorphicDecoration decoration,
		                    this.alignment,
		                    this.width,
		                    this.height,
		                    BoxConstraints constraints,
		                    this.margin,
		                    this.padding,
		                    this.transform,
		                    Key key,
	                    })  : decoration = decoration ?? NeumorphicDecoration(color: color),
				constraints = (width != null || height != null)
						? constraints?.tighten(width: width, height: height) ??
						BoxConstraints.tightFor(width: width, height: height)
						: constraints,
				super(key: key);

	final Widget child;

	/// Elevation relative to parent. Main constituent of Neumorphism
	final double bevel;
	final NeuCurveType curveType;

	/// The decoration to paint behind the [child].
	///
	/// A shorthand for specifying just a solid color is available in the
	/// constructor: set the `color` argument instead of the `decoration`
	/// argument.
	final NeumorphicDecoration decoration;

	final AlignmentGeometry alignment;
	final double width;
	final double height;
	final BoxConstraints constraints;
	final EdgeInsetsGeometry margin;
	final EdgeInsets padding;
	final Matrix4 transform;

	@override
	Widget build(BuildContext context) {
		final color = decoration?.color ?? Theme.of(context).backgroundColor;
		final emboss = curveType == NeuCurveType.emboss;

		Color colorValue = color;

		List<BoxShadow> shadowList = [
			BoxShadow(
				color: _getAdjustColor(color, emboss ? 0 - bevel : bevel),
				offset: Offset(0 - bevel, 0 - bevel),
				blurRadius: bevel,
			),
			BoxShadow(
				color: _getAdjustColor(color, emboss ? bevel : 0 - bevel),
				offset: Offset(bevel, bevel),
				blurRadius: bevel,
			)
		];

		if (emboss) {
			shadowList = [
				BoxShadow(
					color: _getAdjustColor(color, bevel),
					offset: Offset(bevel / 4, bevel / 4),
					blurRadius: bevel / 4,
				),
				BoxShadow(
					color: _getAdjustColor(color, 0 - bevel),
					offset: Offset(0 - bevel / 6, 0 - bevel / 6),
					blurRadius: bevel / 6,
				),
			];

			colorValue = _getAdjustColor(colorValue, 0 - bevel / 2);
		}

		Gradient gradient;
		switch (curveType) {
			case NeuCurveType.concave:
				gradient = _getConcaveGradients(colorValue, bevel);
				break;
			case NeuCurveType.convex:
				gradient = _getConvexGradients(colorValue, bevel);
				break;
			case NeuCurveType.emboss:
			case NeuCurveType.flat:
				gradient = _getFlatGradients(colorValue, bevel);
				break;
		}

		return AnimatedContainer(
			duration: const Duration(milliseconds: 150),
			alignment: alignment,
			width: width,
			height: height,
			constraints: constraints,
			margin: margin,
			padding: padding,
			transform: transform,
			decoration: BoxDecoration(
				borderRadius: decoration.borderRadius,
				gradient: gradient,
				boxShadow: shadowList,
				shape: decoration.shape,
				border: decoration.border,
			),
			child: child,
		);
	}

	Color _getAdjustColor(Color baseColor, double amount) {
		Map<String, int> colors = {
			'r': baseColor.red,
			'g': baseColor.green,
			'b': baseColor.blue
		};

		colors = colors.map((key, value) {
			if (value + amount < 0) {
				return MapEntry(key, 0);
			}
			if (value + amount > 255) {
				return MapEntry(key, 255);
			}
			return MapEntry(key, (value + amount).floor());
		});
		return Color.fromRGBO(colors['r'], colors['g'], colors['b'], 1);
	}

	Gradient _getFlatGradients(Color baseColor, double depth) => LinearGradient(
		begin: Alignment.topLeft,
		end: Alignment.bottomRight,
		colors: [
			baseColor,
			baseColor,
		],
	);

	Gradient _getConcaveGradients(Color baseColor, double depth) =>
			LinearGradient(
				begin: Alignment.topLeft,
				end: Alignment.bottomRight,
				colors: [
					_getAdjustColor(baseColor, 0 - depth),
					_getAdjustColor(baseColor, depth),
				],
			);

	Gradient _getConvexGradients(Color baseColor, double depth) => LinearGradient(
		begin: Alignment.topLeft,
		end: Alignment.bottomRight,
		colors: [
			_getAdjustColor(baseColor, depth),
			_getAdjustColor(baseColor, 0 - depth),
		],
	);
}

class NeumorphicDecoration {
	const NeumorphicDecoration({
		                           this.color,
		                           this.borderRadius,
		                           this.shape = BoxShape.rectangle,
		                           this.border,
	                           });

	final Color color;
	final BorderRadiusGeometry borderRadius;
	final BoxShape shape;
	final BoxBorder border;
}

enum NeuCurveType { concave, convex,emboss,flat }

class NeumorphicProperties {
	final double bevel;
	final double borderRadius;
	final BoxBorder border;
	final BoxShape shape;
	final NeuCurveType curveType;
	final bool showSubtitleText;

	const NeumorphicProperties({
		                           this.bevel = 12.0,
		                           this.borderRadius = 15.0,
		                           this.border,
		                           this.shape = BoxShape.rectangle,
		                           this.curveType = NeuCurveType.concave,
		                           this.showSubtitleText = false,
	                           });
}
