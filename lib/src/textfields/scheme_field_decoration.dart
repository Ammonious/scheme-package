
import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';

class SchemeFieldDecoration {
  final List<BoxShadow> boxShadow;

  /// [NeuTextField] Properties
  ///
  /// This tells the widget to use a different color for the inside of the container, despite whatever is set in the color field.
  final Color cardColor;

  /// This tells the widget to use a different color for the outside emboss/deboss effect, despite whatever is set in the color field.
  final Color parentColor;

  /// This receives a [CurveType] enum. Use this to set the inside surface to look either [convex] or [concave].
  final CurveType curveType;

  /// This is false by default. Set this to true in order to make an embossed container.
  final bool emboss;

  ///  How far should the emboss/deboss effect spread?
  final double spread;

  ///  How strong should the emboss/deboss effect be?
  final int depth;

  final TextStyle textStyle;

  /// This receives a number representing a border radius to be applied to all corners of the container.
  final double borderRadius;
  final double height;
  SchemeFieldDecoration(
      {this.boxShadow,this.borderRadius = 8,
      this.cardColor = Colors.white,
      this.parentColor = Colors.white,
      this.curveType = CurveType.none,
      this.textStyle,
      this.emboss = false,
      this.spread = 6,
        this.height = 72,
      this.depth = 20});


}
