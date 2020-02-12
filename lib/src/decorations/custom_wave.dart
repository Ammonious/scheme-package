import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/utils/color_tools.dart';

class CustomWaveBackground extends StatelessWidget {
  final Color accentColor;
  final Color primaryColor;
  final LinearGradient gradient;
  final double height;
  CustomWaveBackground({
    Key key,
    this.accentColor = Colors.blue,
    this.primaryColor,
    this.gradient, this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              height:height + MediaQuery.of(context).size.height * 0.05 ?? MediaQuery.of(context).size.height * 0.45,
              color: accentColor.shade700.withOpacity(0.25),
            ),
          ),
          ClipPath(
            clipper: WaveClipperOne(),
            child: Container(
              height: height ?? MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  gradient: gradient ?? createGradient(color: primaryColor ?? Colors.blue)),
            ),
          ),
        ],
      ),
    );
  }
}
