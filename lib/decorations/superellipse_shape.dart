import 'dart:math' as math;
import 'package:flutter/material.dart';

class SuperellipseShape extends ShapeBorder {
	/// The arguments must not be null.
	SuperellipseShape({
		                  this.side = BorderSide.none,
		                  this.borderRadius = BorderRadius.zero,
	                  })  : assert(side != null),
				assert(borderRadius != null);

	/// The radii for each corner.
	///
	/// Each corner [Radius] defines the endpoints for a line segment that
	/// spans the corner. The endpoints are located in the same place as
	/// They would be for [RoundedRectangleBorder].
	///
	/// Negative radius values are clamped to 0.0 by [getInnerPath] and
	/// [getOuterPath].
	final BorderRadiusGeometry borderRadius;

	/// The style of this border.
	final BorderSide side;

	@override
	EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

	@override
	ShapeBorder scale(double t) {
		return SuperellipseShape(
			side: side.scale(t),
			borderRadius: borderRadius * t,
		);
	}

	double _clampToShortest(RRect rrect, double value) =>
			value > rrect.shortestSide ? rrect.shortestSide : value;

	Path _getPath(RRect rrect) {
		/// Define the different variables of [rrect].
		final double left = rrect.left;
		final double right = rrect.right;
		final double top = rrect.top;
		final double bottom = rrect.bottom;

		/// Radii will be clamped to the value of the shortest side
		/// of [rrect] to avoid strange tie-fighter shapes.
		final double tlRadiusX =
		math.max(0.0, _clampToShortest(rrect, rrect.tlRadiusX));
		final double tlRadiusY =
		math.max(0.0, _clampToShortest(rrect, rrect.tlRadiusY));
		final double trRadiusX =
		math.max(0.0, _clampToShortest(rrect, rrect.trRadiusX));
		final double trRadiusY =
		math.max(0.0, _clampToShortest(rrect, rrect.trRadiusY));
		final double blRadiusX =
		math.max(0.0, _clampToShortest(rrect, rrect.blRadiusX));
		final double blRadiusY =
		math.max(0.0, _clampToShortest(rrect, rrect.blRadiusY));
		final double brRadiusX =
		math.max(0.0, _clampToShortest(rrect, rrect.brRadiusX));
		final double brRadiusY =
		math.max(0.0, _clampToShortest(rrect, rrect.brRadiusY));

		return Path()
			..moveTo(left, top + tlRadiusX)
			..cubicTo(left, top, left, top, left + tlRadiusY, top)
			..lineTo(right - trRadiusX, top)
			..cubicTo(right, top, right, top, right, top + trRadiusY)
			..lineTo(right, bottom - blRadiusX)
			..cubicTo(right, bottom, right, bottom, right - blRadiusY, bottom)
			..lineTo(left + brRadiusX, bottom)
			..cubicTo(left, bottom, left, bottom, left, bottom - brRadiusY)
			..close();
	}

	@override
	Path getInnerPath(Rect rect, {TextDirection textDirection}) {
		return _getPath(
				borderRadius.resolve(textDirection).toRRect(rect).deflate(side.width));
	}

	@override
	Path getOuterPath(Rect rect, {TextDirection textDirection}) {
		return _getPath(borderRadius.resolve(textDirection).toRRect(rect));
	}

	@override
	void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
		if (rect.isEmpty) return;
		switch (side.style) {
			case BorderStyle.none:
				break;
			case BorderStyle.solid:
				Path path = getOuterPath(rect, textDirection: textDirection);
				var paint = side.toPaint();
				canvas.drawPath(path, paint);
				break;
		}
	}
}