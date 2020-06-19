import 'package:flutter/material.dart';
import 'package:scheme_package/src/global_widgets/auto_size_text.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'package:scheme_theme/scheme_theme.dart';

class SmartText extends StatelessWidget {
  final Color backgroundColor;
  final TextStyle style;
  final String text;
  final int maxLines;
  SmartText({Key key, this.backgroundColor = background, @required this.style, this.text, this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return maxLines != null ? withMaxLines() : normal();
  }

  withMaxLines(){
    return AutoSizeText(
      text,maxLines: maxLines,
      style: style.copyWith(color: backgroundColor.textColor),
    );
  }

  normal(){
    return AutoSizeText(
      text,
      style: style.copyWith(color: backgroundColor.textColor),
    );
  }
}
