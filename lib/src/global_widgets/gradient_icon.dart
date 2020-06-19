import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.data, {
    @required this.gradient,
    this.size = 24,
  });

  final IconData data;
  final Gradient gradient;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(Offset.zero & bounds.size);
      },
      child: Icon(
        data,
        size: size,
      ),
    );
  }
}
