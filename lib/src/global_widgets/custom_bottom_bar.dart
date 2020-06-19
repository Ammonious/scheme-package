import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/navigation/model/nav_data.dart';
import 'package:scheme_package/src/ui/styles.dart';

import 'package:scheme_theme/scheme_theme.dart';
class CustomBottomBar extends StatelessWidget {
  final Function onTapPrimary;
  final Function onTapSecondary;
  final String primaryTitle;
  final String secondaryTitle;
  final TextStyle stylePrimary;
  final TextStyle styleSecondary;
  final Color primaryColor;
  final Color secondaryColor;
  final bool isLoading;
  final bool secondaryEnabled;
  final double height;
  final IconData primaryIcon;
  final String heroTagPrimary;
  final String heroTagSecondary;
  final SchemeBarStyle schemeBarStyle;
  final Color parentColor;
  final double iconSize;
  CustomBottomBar({
    Key key,
    this.onTapPrimary,
    this.onTapSecondary,
    this.primaryTitle = '',
    this.secondaryTitle = '',
    this.stylePrimary,
    this.styleSecondary,
    this.primaryColor = Colors.blue,
    this.secondaryColor = nearlyBlack,
    this.isLoading = false,
    this.secondaryEnabled = false,
    this.height = 60,
    this.primaryIcon,
    this.heroTagPrimary = 'primary',
    this.heroTagSecondary = 'secondary',
    this.schemeBarStyle = SchemeBarStyle.flat,
    this.parentColor, this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height + bottomPadding,
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, -2))],
          color: parentColor ?? neuBackground),
      child: Row(
        children: <Widget>[
          Flexible(flex:5,
            child: Container(
              width: screenWidth,
              height: height + bottomPadding,
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onTapSecondary != null ?  onTapSecondary() : null,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  splashColor: primaryColor.withOpacity(0.2),
                  child: Container(
                    width: screenWidth / 2,
                    child: Visibility(
                      visible: secondaryEnabled,
                      child: Center(
                        child: AutoSizeText(
                          secondaryTitle,maxLines: 1,
                          style: styleSecondary != null
                              ? styleSecondary.copyWith(color: secondaryColor.textColor)
                              : schemeBtnFont.copyWith(color: secondaryColor.textColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(flex: 5,child: initStyle(context))
        ],
      ),
    );
  }


  initStyle(BuildContext context){
  	switch(schemeBarStyle){
  	  case SchemeBarStyle.flat:
  	    return normalStyle(context);
  	  case SchemeBarStyle.neu:
  	    return neuStyle(context);
	  }
  }





  neuStyle(BuildContext context) => Container(width: screenWidth,height: height + bottomPadding,
    padding: EdgeInsets.only(bottom:bottomPadding + 8,left: 16, right: 16,top: 8),
    child: NeuButton(
		    parentColor: parentColor,
		    onTap: () => onTapPrimary != null ?  onTapPrimary() : null,
		    height: height - 8,
		    width: screenWidth,
		    iconData: primaryIcon,
		    iconColor: primaryColor,
		    textColor: primaryColor,
		    label: primaryTitle,
		    iconSize: iconSize,
		    textStyle: stylePrimary != null
				    ? stylePrimary.copyWith(color: primaryColor.shade700.textColor)
				    : schemeBtnFont.copyWith(
			    color: primaryColor.textColor,
		    )),
  );

  normalStyle(BuildContext context) => Hero(
	  tag: heroTagPrimary,
	  child: Container(
			  height: height + bottomPadding,
			  width: screenWidth / 2,
			  decoration: BoxDecoration(
				  boxShadow: [
					  BoxShadow(
							  blurRadius: 10.25,
							  color: primaryColor.withOpacity(0.4),
							  offset: Offset.zero)
				  ],
				  borderRadius: BorderRadius.only(topLeft: Radius.circular(24)),
				  gradient: schemeGradient(color: primaryColor),
			  ),
			  child: Material(
				  color: Colors.transparent,
				  child: InkWell(
					  borderRadius: BorderRadius.only(topLeft: Radius.circular(24)),
					  onTap: () => onTapPrimary != null ?  onTapPrimary() : null,
					  child: Container(
						  height: height + bottomPadding,
						  padding: EdgeInsets.only(bottom: bottomPadding),
						  width: screenWidth / 2,
						  decoration: BoxDecoration(
								  borderRadius: BorderRadius.only(topLeft: Radius.circular(24))),
						  child: Center(
							  child: Row(
								  mainAxisSize: MainAxisSize.min,
								  crossAxisAlignment: CrossAxisAlignment.center,
								  children: <Widget>[
									  Visibility(
											  visible: primaryIcon != null,
											  child: Icon(
												  primaryIcon ?? Boxicons.bxDiamond,
												  color: primaryColor.shade700.textColor,
											  )),
									  SizedBox(
										  width: primaryIcon != null ? 12 : 0,
									  ),
									  AutoSizeText(
										  primaryTitle,maxLines: 1,
										  style: stylePrimary != null
												  ? stylePrimary.copyWith(color: primaryColor.shade700.textColor)
												  : schemeBtnFont.copyWith(color: primaryColor.textColor),
									  ),
								  ],
							  ),
						  ),
					  ),
				  ),
			  )),
  );
}
