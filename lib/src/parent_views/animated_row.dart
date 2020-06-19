import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

enum AnimatedRowType {fromRight,fromBottom,fromTop,fromLeft}
class AnimatedRow extends StatelessWidget {
	final int index;
	final Widget child;
	final AnimatedRowType animationType;
	AnimatedRow({Key key,@required this.index,@required this.child, this.animationType = AnimatedRowType.fromRight}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		// TODO: implement build
		return AnimationConfiguration.staggeredList(
			position: index,
			duration: const Duration(milliseconds: 375),
			child: initChild
		);
	}


	get initChild {
		switch(animationType){
		  case AnimatedRowType.fromRight:
		   return horizontalSlide();
		  case AnimatedRowType.fromBottom:
			  return verticalSlide();
		  case AnimatedRowType.fromTop:
			  return verticalSlide();
		  case AnimatedRowType.fromLeft:
			  return horizontalSlide();
		}
	}

	horizontalSlide() =>  SlideAnimation(
		horizontalOffset: animationType == AnimatedRowType.fromRight ?  50.0 : -50.0,
		child: FadeInAnimation(
			child: child,
		),
	);

	verticalSlide() =>  SlideAnimation(
		verticalOffset: animationType == AnimatedRowType.fromBottom ?  50.0 : -50.0,
		child: FadeInAnimation(
			child: child,
		),
	);
}