
import 'package:flutter/material.dart';
import 'package:scheme_package/src/utils/constants.dart';
import 'package:scheme_package/src/ui/styles.dart';

class CustomAppBar extends StatelessWidget {
	final ScrollController scrollController;
	final bool enableBack;
	final Color collapsedBarColor;
	final Color barTitleColor;
	final String title;
	final Function onBackPressed;
	final double opacity;
	final Animation topBarAnimation;
	final AnimationController animationController;
	final Animatable<Color> animateText;
	final TextStyle textStyle;
	final bool showTitle;
	CustomAppBar(
			{Key key,
				this.scrollController,
				this.enableBack = false,
				this.collapsedBarColor,
				this.barTitleColor,
				this.title,
				this.onBackPressed,
				this.opacity,
				this.topBarAnimation,
				this.animationController, this.animateText, this.textStyle, this.showTitle = false})
			: super(key: key);

	@override
	Widget build(BuildContext context) {
		return AnimatedContainer(
			duration: normalDuration,
			child: Column(
				children: <Widget>[
					AnimatedBuilder(
						animation: animationController,
						builder: (BuildContext context, Widget child) {
							return FadeTransition(
								opacity: topBarAnimation,
								child: Container(
									height: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
									padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
									decoration: BoxDecoration(
										color: collapsedBarColor.withOpacity(opacity),
										borderRadius: BorderRadius.only(
											bottomLeft: Radius.circular(34.0),
										),
										boxShadow: <BoxShadow>[
											BoxShadow(
													color: Colors.black.withOpacity(0.4 * opacity),
													offset: Offset(1.1, 1.1),
													blurRadius: 10.0),
										],
									),
									child: Stack(
										children: <Widget>[

											Visibility(visible:showTitle,
											  child: Align(
											  	alignment: Alignment.center,
											  	child: Text(
											  		title,
											  		style: textStyle ?? subtitle1,

											  	),
											  ),
											),
											Visibility(
												visible: enableBack,
												child: Align(
													alignment: Alignment.centerLeft,
													child: IconButton(
														onPressed: () => onBackPressed(),
														icon: Icon(
															Icons.arrow_back_ios,
															color: animateText.evaluate(AlwaysStoppedAnimation(opacity)),
														),
													),
												),
											),
										],
									),
								),
							);
						},
					)
				],
			),
		);
	}
}
