import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';

class NeuDecoration extends StatefulWidget {
	final Color parentColor;
	final BubblePosition position;
	final double size;
	final Widget child;
  const NeuDecoration({Key key, this.parentColor, this.position = BubblePosition.BottomLeft, this.size = 240, this.child}) : super(key: key);
	@override
	_NeuDecorationState createState() => _NeuDecorationState();
}

class _NeuDecorationState extends State<NeuDecoration> with SingleTickerProviderStateMixin {
	Color get baseColor => widget.parentColor ??  Color(0xFFf2f2f2);
	double firstDepth = 50;
	double secondDepth = 50;
	double thirdDepth = 50;
	double fourthDepth = 50;
	AnimationController _animationController;
	double get size => widget.size;
	  BubblePosition get position => widget.position;
	  get child => widget.child ?? Container();
	@override
	void initState() {
		_animationController = AnimationController(
			vsync: this, // the SingleTickerProviderStateMixin
			duration: Duration(seconds: 5),
		)..addListener(() {
			if(_animationController.status == AnimationStatus.completed) _animationController.reverse();
			if(_animationController.status == AnimationStatus.dismissed) _animationController.forward();
			setState(() {});
		});

		_animationController.forward();

		super.initState();
	}

	@override
	void dispose() {
		_animationController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		double stagger(value, progress, delay) {
			progress = progress - (1 - delay);
			if (progress < 0) progress = 0;
			return value * (progress / delay);
		}

		double calculatedFirstDepth =
		stagger(firstDepth, _animationController.value, 0.25);
		double calculatedSecondDepth =
		stagger(secondDepth, _animationController.value, 0.5);
		double calculatedThirdDepth =
		stagger(thirdDepth, _animationController.value, 0.75);
		double calculatedFourthDepth =
		stagger(fourthDepth, _animationController.value, 1);

		return Stack(
		  children: <Widget>[
		    DecorationPositionView(position: position,child: ClayContainer(
		    	color: baseColor,
		    	height: size,
		    	width: size,
		    	borderRadius: size * .5,
		    	curveType: CurveType.concave,
		    	spread: 30,
		    	depth: calculatedFirstDepth.toInt(),
		    	child: Center(
		    		child: ClayContainer(
		    			height: size - 40,
		    			width: size - 40,
		    			borderRadius: size * .5,
		    			depth: calculatedSecondDepth.toInt(),
		    			curveType: CurveType.convex,
		    			color: baseColor,
		    			child: Center(
		    				child: ClayContainer(
		    						height: size - 80,
		    						width: size - 80,
		    						borderRadius: size * .5,
		    						color: baseColor,
		    						depth: calculatedThirdDepth.toInt(),
		    						curveType: CurveType.concave,
		    						child: Center(
		    								child: ClayContainer(
		    									height: size * .5,
		    									width: size * .5,
		    									borderRadius: size * .25,
		    									color: baseColor,
		    									depth: calculatedFourthDepth.toInt(),
		    									curveType: CurveType.convex,
											    child: Center(child: SizedBox(width: (size * .46),height: (size * .46), child: child,),),
		    								))),
		    			),
		    		),
		    	),
		    ),),
		  ],
		);
	}
}