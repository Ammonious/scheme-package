import 'dart:ui';

import 'package:flutter/material.dart';


class DashedContainer extends StatelessWidget {
	final Color dashColor;

	/// Width of the stroke, default is 1.0
	final double strokeWidth;

	/// Length of blank space, default 5.0
	final double blankLength;

	/// Length of dashed line, default 5.0
	final double dashedLength;
	final Widget child;
	final double borderRadius;
	final BoxShape boxShape;

	DashedContainer({
		                @required this.child,
		                this.dashColor = Colors.black,
		                this.strokeWidth = 1.0,
		                this.blankLength = 5.0,
		                this.dashedLength = 5.0,
		                this.borderRadius = 0.0,
		                this.boxShape = BoxShape.rectangle,
	                });

	@override
	Widget build(BuildContext context) {
		final Paint mPaint = Paint()
			..color = dashColor
			..strokeWidth = strokeWidth
			..style = PaintingStyle.stroke;
		return CustomPaint(
			painter: DashPathPainter(
				mPaint: mPaint,
				blankWidth: blankLength,
				dashedWidth: dashedLength,
				borderRadius: borderRadius,
				boxShape: boxShape,
			),
			child: child,
		);
	}
}

class DashPathPainter extends CustomPainter {
	final Paint mPaint;
	final double blankWidth;
	final double dashedWidth;
	final double borderRadius;
	final BoxShape boxShape;

	DashPathPainter({
		                @required this.mPaint,
		                this.blankWidth,
		                this.dashedWidth,
		                this.borderRadius,
		                this.boxShape,
	                });

	@override
	bool shouldRepaint(DashPathPainter oldDelegate) => true;

	@override
	void paint(Canvas canvas, Size size) {
		Path p;
		double bRadius = borderRadius;

		if (boxShape == BoxShape.rectangle) {
			if (bRadius == 0)
				p = Path()..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
			else {
				Radius radius = Radius.circular(bRadius);
				p = Path()
					..addRRect(
						RRect.fromRectAndCorners(
							Rect.fromLTWH(0.0, 0.0, size.width, size.height),
							bottomLeft: radius,
							bottomRight: radius,
							topLeft: radius,
							topRight: radius,
						),
					);
			}
		} else {
			bRadius = size.width / 2;
			Radius radius = Radius.circular(bRadius);
			p = Path()
				..addRRect(
					RRect.fromRectAndCorners(
						Rect.fromLTWH(0.0, 0.0, size.width, size.height),
						bottomLeft: radius,
						bottomRight: radius,
						topLeft: radius,
						topRight: radius,
					),
				);
		}
		canvas.drawPath(
			dashPath(
				p,
				dashArray: CircularIntervalList<double>(
					<double>[
						dashedWidth,
						blankWidth,
					],
				),
			),
			mPaint,
		);
	}
}

/// Creates a new path that is drawn from the segments of `source`.
///
/// Dash intervals are controled by the `dashArray` - see [CircularIntervalList]
/// for examples.
///
/// `dashOffset` specifies an initial starting point for the dashing.
///
/// Passing in a null `source` will result in a null result.  Passing a `source`
/// that is an empty path will return an empty path.
Path dashPath(
		Path source, {
			@required CircularIntervalList<double> dashArray,
			DashOffset dashOffset,
		}) {
	assert(dashArray != null);
	if (source == null) {
		return null;
	}

	dashOffset = dashOffset ?? const DashOffset.absolute(0.0);
	// TODO: Is there some way to determine how much of a path would be visible today?

	final Path dest = Path();
	for (final PathMetric metric in source.computeMetrics()) {
		double distance = dashOffset._calculate(metric.length);
		bool draw = true;
		while (distance < metric.length) {
			final double len = dashArray.next;
			if (draw) {
				dest.addPath(metric.extractPath(distance, distance + len), Offset.zero);
			}
			distance += len;
			draw = !draw;
		}
	}

	return dest;
}

enum _DashOffsetType { Absolute, Percentage }

/// Specifies the starting position of a dash array on a path, either as a
/// percentage or absolute value.
///
/// The internal value will be guaranteed to not be null.
class DashOffset {
	/// Create a DashOffset that will be measured as a percentage of the length
	/// of the segment being dashed.
	///
	/// `percentage` will be clamped between 0.0 and 1.0; null will be converted
	/// to 0.0.
	DashOffset.percentage(double percentage)
			: _rawVal = percentage.clamp(0.0, 1.0) ?? 0.0,
				_dashOffsetType = _DashOffsetType.Percentage;

	/// Create a DashOffset that will be measured in terms of absolute pixels
	/// along the length of a [Path] segment.
	///
	/// `start` will be coerced to 0.0 if null.
	const DashOffset.absolute(double start)
			: _rawVal = start ?? 0.0,
				_dashOffsetType = _DashOffsetType.Absolute;

	final double _rawVal;
	final _DashOffsetType _dashOffsetType;

	double _calculate(double length) {
		return _dashOffsetType == _DashOffsetType.Absolute ? _rawVal : length * _rawVal;
	}
}

/// A circular array of dash offsets and lengths.
///
/// For example, the array `[5, 10]` would result in dashes 5 pixels long
/// followed by blank spaces 10 pixels long.  The array `[5, 10, 5]` would
/// result in a 5 pixel dash, a 10 pixel gap, a 5 pixel dash, a 5 pixel gap,
/// a 10 pixel dash, etc.
///
/// Note that this does not quite conform to an [Iterable<T>], because it does
/// not have a moveNext.
class CircularIntervalList<T> {
	CircularIntervalList(this._vals);

	final List<T> _vals;
	int _idx = 0;

	T get next {
		if (_idx >= _vals.length) {
			_idx = 0;
		}
		return _vals[_idx++];
	}
}