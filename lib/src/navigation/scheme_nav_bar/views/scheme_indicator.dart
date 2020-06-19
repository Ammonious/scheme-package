import 'package:flutter/material.dart';

class SchemeIndicator {
  /// Contains a custom view shape
  final ShapeBorder shape;

  ///Used to custom shapes to change bounds:
  ///
  /// if [centered] is true  -> element bounds are square with default padding
  /// if [centered] is false -> element bounds fills the container size
  final bool centered;

  /// Used internal for distinction defined and custom shapes
  final SchemeIndicatorType type;

  SchemeIndicator({@required this.shape, this.centered = true})
      : type = SchemeIndicatorType.custom;

  const SchemeIndicator._internal({this.shape, this.type, this.centered});

  SchemeIndicator copyWith({ShapeBorder shape, bool centered}) {
    return SchemeIndicator._internal(
      shape: shape ?? this.shape,
      type: this.type,
      centered: centered ?? this.centered,
    );
  }

  static const SchemeIndicator circle = SchemeIndicator._internal(
      shape: null, type: SchemeIndicatorType.circle, centered: false);

  static const SchemeIndicator rectangle = SchemeIndicator._internal(
      shape: null, type: SchemeIndicatorType.rectangle, centered: false);

  static const SchemeIndicator indicator = SchemeIndicator._internal(
      shape: null, type: SchemeIndicatorType.indicator, centered: false);
}

enum SchemeIndicatorType { circle, rectangle, indicator, custom }