import 'package:scheme_package/utils/color_tools.dart';
import 'package:flutter/material.dart';

createGradient({Color color, Color colorOne, Color colorTwo, Alignment begin, Alignment end}) {
  return LinearGradient(
      begin: begin ?? Alignment.topLeft,
      end: end ?? Alignment.bottomRight,
      stops: [0.1, 1],
      colors: colorOne == null && colorTwo == null
          ? [
              color.shade500,
              color.shade700,
            ]
          : [colorOne, colorTwo]);
}
