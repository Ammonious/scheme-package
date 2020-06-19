import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_theme/scheme_theme.dart';
class LoadingView extends StatelessWidget {
  final Color color;
  final double height;
  final Color backgroundColor;
  LoadingView({Key key, this.color = Colors.blue, this.height, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double padding = height != null && height >= screenHeight ? appbarWithPadding : 0;
    return height != null ? heightLoader(padding) : noHeightLoader;
  }

  
   heightLoader(double padding) => Container(padding: EdgeInsets.only(top: padding,bottom:padding), height: height,
   color: backgroundColor ?? Colors.transparent,
   child: Center(
     child: CircularProgressIndicator(
       valueColor: AlwaysStoppedAnimation(color),
     ),
   ),
 );
  
 get noHeightLoader => Container(
  color: backgroundColor ?? Colors.transparent,
  child: Center(
  child: CircularProgressIndicator(
  valueColor: AlwaysStoppedAnimation(color),
  ),
  ),
  );

}
