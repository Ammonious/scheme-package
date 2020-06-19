import 'package:flutter/material.dart';

class RelativeBaseLayout extends StatelessWidget {
	final Widget child;
RelativeBaseLayout({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(color:Colors.transparent,child: Container(child: child,),);
  }
}
