import 'package:flutter/material.dart';
import 'package:scheme_package/src/icons/constants/box_icons.dart';
import 'package:scheme_package/src/neumorphic/neu_container.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'package:scheme_package/scheme_package.dart' hide CurveType;
class NeuSelectionButton extends StatelessWidget {
	final NeumorphicProperties neumorphicProperties;
	final Color parentColor;
	final bool isSelected;
	final double height;
	final Widget icon;
	final IconData iconData;
	final Color selectedColor;
	final Function onTap;
NeuSelectionButton({Key key, this.neumorphicProperties, this.parentColor, this.isSelected, this.height, this.icon, this.iconData, this.selectedColor, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(color:Colors.transparent,child: GestureDetector(onTap: () => onTap(),
      child: NeumorphicContainer(
	    decoration: NeumorphicDecoration(
		    borderRadius: BorderRadius.circular(
				    this.neumorphicProperties == null ? 15.0 : this.neumorphicProperties.borderRadius),
		    color: parentColor,
		    border: this.neumorphicProperties == null ? null : this.neumorphicProperties.border,
		    shape: this.neumorphicProperties == null
				    ? BoxShape.rectangle
				    : this.neumorphicProperties.shape,
	    ),
	    bevel: this.neumorphicProperties == null ? 12.0 : this.neumorphicProperties.bevel,
	    curveType: isSelected
			    ? NeuCurveType.emboss
			    : this.neumorphicProperties == null
			    ? NeuCurveType.concave
			    : this.neumorphicProperties.curveType,
	    height: height,
	    child: Padding(
		    padding: EdgeInsets.only(left: isSelected ? 12 : 18, right: isSelected ? 12 : 18, top: 8, bottom: 8),
		    child: Row(mainAxisAlignment: MainAxisAlignment.center,
			    mainAxisSize: MainAxisSize.min,
			    children: <Widget>[
				    if(icon != null) innerItem,
				    if(iconData != null) iconView,
			    ],
		    ),
	    ),
      ),
    ),);
  }




	get innerItem => Visibility(
		visible: icon != null,
		child: Padding(
			padding: EdgeInsets.only(right:isSelected ? 8.0 : 2),
			child: IconTheme(
				data: IconThemeData(
						color: isSelected
								? (selectedColor == null ? selectedColor : parentColor.textColor)
								: parentColor.textColor),
				child: icon,
			),
		),
	);

	get iconView => Visibility(
		visible: iconData != null,
		child: Container(
			margin: EdgeInsets.only(right: isSelected ? 8.0 : 2),
			child: Icon(
				iconData ?? BoxIcon.bxCheck,
				color: isSelected ? selectedColor : parentColor.textColor,
			),
		),
	);
}

