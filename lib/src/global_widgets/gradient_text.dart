import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'auto_size_text.dart';

class GradientText extends StatelessWidget {
	final double maxFontSize;
	final double minFontSize;
	final String data;
	final Gradient gradient;
	final TextStyle style;
	final TextAlign textAlign;
	final int maxLines;
  GradientText(this.data,
      {@required this.gradient,
      this.style,
      this.textAlign = TextAlign.left,
      this.maxLines,
      this.maxFontSize,
      this.minFontSize});


  @override
  Widget build(BuildContext context) => kIsWeb
      ? autoSizeText
      : ShaderMask(
          shaderCallback: (bounds) =>
              gradient.createShader(Offset.zero & bounds.size),
          child: autoSizeText,
        );

  get autoSizeText => AutoSizeText(
        data,
        maxLines: maxLines,
        minFontSize: minFontSize ?? 0,
        maxFontSize: maxFontSize ?? 100,
        textAlign: textAlign,
        style: (style == null)
            ? TextStyle(color: Colors.white)
            : style.copyWith(color: Colors.white),
      );
}
