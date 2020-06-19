import 'package:flutter/material.dart';
import 'dart:math' show sqrt, max;
import 'dart:ui' show lerpDouble;

import 'package:sa_stateless_animation/sa_stateless_animation.dart';


class CircularRevealAnimation extends StatelessWidget {
  final Alignment centerAlignment;
  final Offset centerOffset;
  final double minRadius;
  final double maxRadius;
  final Widget child;
  final CustomAnimationControl control;
  final int duration;

  /// Creates [CircularRevealAnimation] with given params.
  /// For open animation [animation] should run forward: [AnimationController.forward].
  /// For close animation [animation] should run reverse: [AnimationController.reverse].
  ///
  /// [centerAlignment] center of circular reveal. [centerOffset] if not specified.
  /// [centerOffset] center of circular reveal. Child's center if not specified.
  /// [centerAlignment] or [centerOffset] must be null (or both).
  ///
  /// [minRadius] minimum radius of circular reveal. 0 if not if not specified.
  /// [maxRadius] maximum radius of circular reveal. Distance from center to further child's corner if not specified.
  CircularRevealAnimation({
    @required this.child,
    @required this.control,
    @Deprecated("use centerOffset or centerAlignment") Offset center,
    this.centerAlignment,
    Offset centerOffset,
    this.minRadius,
    this.maxRadius,
    this.duration = 500,
  })  : assert(child != null),

        // ignore: deprecated_member_use_from_same_package
        centerOffset = centerOffset ?? center {
    assert(this.centerAlignment == null || this.centerOffset == null);
  }

  final tween = Tween(begin: 0.0,end: 1.0);

  @override
  Widget build(BuildContext context) {
     return Container();
  }
}




class RevealPainter extends CustomPainter {
	final Color color;
	final double fraction;
	final Alignment centerAlignment;
	final Offset centerOffset;
	final double minRadius;
	final double maxRadius;
  RevealPainter( {this.color,this.fraction, this.centerAlignment, this.centerOffset, this.minRadius, this.maxRadius,});

	@override
	void paint(Canvas canvas, Size size) {

		Paint paint = Paint();
		paint.color = color;
		final Offset center = this.centerAlignment?.alongSize(size) ??
				this.centerOffset ??
				Offset(size.width / 2, size.height / 2);
		final minRadius = this.minRadius ?? 0;
		final maxRadius = this.maxRadius ?? calcMaxRadius(size, center);
		canvas.drawPath(Path()
			..addOval(
				Rect.fromCircle(
					center: center,
					radius: lerpDouble(minRadius, maxRadius, fraction),
				),
			), paint);

	}

	@override
	bool shouldRepaint(CustomPainter oldDelegate) {
		return true;
	}

	static double calcMaxRadius(Size size, Offset center) {
		final w = max(center.dx, size.width - center.dx);
		final h = max(center.dy, size.height - center.dy);
		return sqrt(w * w + h * h);
	}
}
