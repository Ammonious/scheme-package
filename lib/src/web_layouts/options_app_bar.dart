import 'package:flutter/material.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'package:scheme_package/scheme_package.dart' hide normalShadow;

class OptionsAppBar extends StatelessWidget {
  final double height;
  final String imagePath;
  final Color color;
  final List<BoxShadow> boxShadow;
  final Widget logo;
  final List<Widget> options;
  final EdgeInsets padding;
  OptionsAppBar(
      {Key key,
      this.height = 120,
      this.imagePath,
      this.color = Colors.white,
      this.boxShadow,
      this.logo,
      this.options,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: height ?? appbarWithPadding,
        padding: padding ?? EdgeInsets.only(top: topPadding , bottom: 16),
        margin: EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(color: color, boxShadow: boxShadow ?? normalShadow),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: 8,
            ),
            imagePath != null
                ? CustomImage(
                    height: AppBar().preferredSize.height * .75,
                    width: 150,
                    imagePath: imagePath,
                  )
                : logo ?? Container(),
            SizedBox(
              width: 24,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: options != null ? options : <Widget>[],
              ),
            ),
            SizedBox(
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}
