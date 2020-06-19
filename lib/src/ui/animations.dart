import 'package:flutter/material.dart';

Animation<Color>  colorAnimation({AnimationController controller, Color startColor, Color endColor}) => ColorTween(
      begin: startColor,
      end: endColor,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
