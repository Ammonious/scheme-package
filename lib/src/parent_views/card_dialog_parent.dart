import 'package:flutter/material.dart';
import 'package:scheme_theme/scheme_theme.dart';

import '../../scheme_package.dart';

class CardDialogParent extends StatelessWidget {
	final Widget child;
	final EdgeInsets padding;
	final double maxWidth;
	final double maxHeight;
CardDialogParent({Key key, this.child, this.padding = const EdgeInsets.all(0), this.maxWidth,this.maxHeight }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),elevation: 16,
      child: Material(color:Colors.transparent,child: Container(
	    padding: padding,
	    constraints: BoxConstraints(maxWidth: maxWidth ?? screenWidth,maxHeight: maxHeight ?? screenHeight),

	    child: child,
      ),),
    );
  }
}
