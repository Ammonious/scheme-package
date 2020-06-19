import 'package:flutter/material.dart';
import 'package:scheme_package/src/decorations/shapes/superellipse_shape.dart';
import 'package:scheme_package/src/selection/selection_constants.dart';
import 'package:scheme_theme/scheme_theme.dart';

class GradientCheckbox extends StatelessWidget {
  final double size;
  final IconData iconData;
  final LinearGradient selectedGradient;
  final CheckboxShape shape;
  GradientCheckbox({Key key, this.size = 32, this.iconData, this.selectedGradient, this.shape}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedContainer(
        duration: normalDuration,
        decoration: BoxDecoration(),
        height: size,
        width: size,
        child: Icon(
          iconData,
          color: Colors.white,
          size: size - 6,
        ),
      )
    );
  }


  setShape(bool selected){
    switch(shape){

      case CheckboxShape.SuperEllipse:
        // TODO: Handle this case.
        return superEllipseDecoration(selected ? normalShadow : liftedShadow, selectedGradient, selected ? Colors.transparent : Colors.grey.shade700);
      case CheckboxShape.Square:
        // TODO: Handle this case.
        break;
      case CheckboxShape.Circle:
        // TODO: Handle this case.
        break;
    }
  }

  ShapeDecoration superEllipseDecoration(List<BoxShadow> boxShadow, LinearGradient gradient,Color color) =>
      ShapeDecoration(color: color,
        gradient: gradient,
        shadows: boxShadow ?? liftedShadow,
        shape: SuperellipseShape(
          borderRadius: BorderRadius.circular(28.0),
        ),
      );

  BoxDecoration regularThemeDecoration(
      List<BoxShadow> boxShadow, LinearGradient gradient, BorderRadius borderRadius) =>
      BoxDecoration(boxShadow: boxShadow, gradient: gradient, borderRadius: borderRadius);

}
