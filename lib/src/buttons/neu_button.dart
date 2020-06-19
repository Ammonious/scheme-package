
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheme_package/src/icons/constants/box_icons.dart';
import 'package:scheme_package/scheme_package.dart' hide CurveType;
import 'package:scheme_package/src/neumorphic/neu_container.dart';
import 'package:scheme_theme/scheme_theme.dart';


class NeuButton extends StatefulWidget {


  final double height;
  final Color parentColor;
  final NeumorphicProperties neumorphicProperties;
  final IconData iconData;
  final double iconSize;
  final Color iconColor;
  final Color textColor;
  final Function onTap;
  final String label;
  final TextStyle textStyle;
  final bool isSelected;
  final double width;
	final bool enabled;
  final Widget child;
 const NeuButton(
      {Key key,
      this.height = 42,
      this.parentColor,
      this.iconData,
      this.iconSize = 20,
      this.iconColor,
      this.textColor,
      this.onTap,
      this.label = '',
      this.textStyle, this.isSelected, this.neumorphicProperties, this.width, this.child, this.enabled = true})
      : super(key: key);

  @override
  _NeuButtonState createState() => _NeuButtonState();
}

class _NeuButtonState extends State<NeuButton> {

	int depth;
	double spread;
	NeuCurveType curveType;
	Color surfaceColor;
	bool pressed = false;
	bool get enabled => widget.enabled;

	void updateInitialStyle() {
		setState(() {
			if(widget.isSelected != null && widget.isSelected){
				depth = 0;
				pressed = true;
			} else {
				pressed = false;
			}
		});
	}
	@override
	void initState() {
		super.initState();
		updateInitialStyle();
	}

	@override
	void didChangeDependencies() {
		super.didChangeDependencies();
		updateInitialStyle();
	}



	@override
	void didUpdateWidget(NeuButton oldWidget) {
		super.didUpdateWidget(oldWidget);
		updateInitialStyle();
	}

	_resetIfTapUp() {
		if (hasFinishedAnimationDown == true && hasTapUp == true && !hasDisposed) {
			setState(() {
				pressed = false;

				hasFinishedAnimationDown = false;
				hasTapUp = false;
			});
		}
	}
	Future<void> _handlePress() async {

		hasFinishedAnimationDown = false;

		setState(() {
			pressed = true;
			depth = 0;
		});

		await Future.delayed(Duration(milliseconds: 100)); //wait until animation finished
		hasFinishedAnimationDown = true;

		if(widget.isSelected == null) _resetIfTapUp();
	}

	bool hasDisposed = false;
	bool get clickable => widget.onTap != null;

	bool hasFinishedAnimationDown = false;
	bool hasTapUp = false;

	@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    hasDisposed = true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
	      onTapDown: (detail) {
		      if (clickable && !pressed && !hasDisposed && enabled) {
			      _handlePress();
		      }
	      },
	      onTapUp: (details) {
		      if (clickable) {
			      widget.onTap();
		      }
		      hasTapUp = true;
		      _resetIfTapUp();
	      },
	      onTapCancel: () {
		      hasTapUp = true;
		      _resetIfTapUp();
	      },
        child: widget.width != null ? neuWidth : neuDynamic
      ),
    );
  }

 get neuDynamic =>  NeumorphicContainer(
	 decoration: NeumorphicDecoration(
		 borderRadius: BorderRadius.circular(widget.neumorphicProperties == null
				 ? 15.0
				 : widget.neumorphicProperties.borderRadius),
		 color: widget.parentColor ?? neuBackground,
		 border: widget.neumorphicProperties == null ? null : widget.neumorphicProperties.border,
		 shape: widget.neumorphicProperties == null
				 ? BoxShape.rectangle
				 : widget.neumorphicProperties.shape,
	 ),
	 bevel: widget.neumorphicProperties == null ? 12.0 : widget.neumorphicProperties.bevel,
	 curveType: pressed
			 ? NeuCurveType.emboss
			 : widget.neumorphicProperties == null
			 ? NeuCurveType.concave
			 : widget.neumorphicProperties.curveType,
	 height: widget.height,
	 child: widget.child != null ? widget.child : innerView,
 );

  get neuWidth =>  NeumorphicContainer(
	decoration: NeumorphicDecoration(
	borderRadius: BorderRadius.circular(widget.neumorphicProperties == null
	? 15.0
			: widget.neumorphicProperties.borderRadius),
	color: widget.parentColor ?? neuBackground,
	border: widget.neumorphicProperties == null ? null : widget.neumorphicProperties.border,
	shape: widget.neumorphicProperties == null
	? BoxShape.rectangle
			: widget.neumorphicProperties.shape,
	),
	bevel: widget.neumorphicProperties == null ? 12.0 : widget.neumorphicProperties.bevel,
	curveType: pressed
	? NeuCurveType.emboss
			: widget.neumorphicProperties == null
	? NeuCurveType.concave
			: widget.neumorphicProperties.curveType,
	height: widget.height,
	  width: widget.width,
	child: widget.child != null ? widget.child : innerView,
	);



  get innerView => Padding(
	  padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
	  child: Row(mainAxisAlignment: MainAxisAlignment.center,
		  mainAxisSize: MainAxisSize.min,
		  children: <Widget>[
			  Visibility(
				  visible: widget.iconData != null,
				  child: Flexible(flex: 3,
				    child: Container(
					  margin: EdgeInsets.only(right: 8),
					  child: Icon(
						  widget.iconData ?? BoxIcon.bxCheck,color: widget.iconColor ?? widget.parentColor.textColor,size: widget.iconSize,
					  ),
				    ),
				  ),
			  ),
			  Flexible(flex: 9,
			    child: AutoSizeText(
				  widget.label,maxLines: 1,
				  style: widget.textStyle != null
						  ? widget.textStyle.copyWith(color: widget.textColor ?? widget.parentColor.textColor)
						  : GoogleFonts.raleway(
						  fontWeight: FontWeight.w600,
						  fontSize: 16,
						  color: widget.textColor ?? widget.parentColor.textColor),
			    ),
			  )
		  ],
	  ),
  );


}
