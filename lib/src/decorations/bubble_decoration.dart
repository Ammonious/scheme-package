
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:scheme_theme/scheme_theme.dart';

import 'bubble_view.dart';

enum BubblePosition { TopRight, TopLeft, BottomRight, BottomLeft, TopCenter,BottomCenter }

class BubbleDecoration extends StatelessWidget {
	final ParentStyle mainBubbleStyle;
	final ParentStyle innerBubbleStyle;
	final BubblePosition position;
	BubbleDecoration({Key key, this.mainBubbleStyle, this.innerBubbleStyle, this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(color:Colors.transparent,child: Stack(
	    children: <Widget>[
		    BubbleView(
			    size: mainBubbleStyle.exportStyle.height * mainBubbleStyle.exportStyle.scale,
			    position: position,
			    vPadding: mainBubbleStyle.exportStyle.offset.dy,
			    hPadding: mainBubbleStyle.exportStyle.offset.dx,
			    color: mainBubbleStyle.exportStyle.backgroundColor,
		    ),
		    BubbleView(
			    size: innerBubbleStyle.exportStyle.height * innerBubbleStyle.exportStyle.scale,
			    position: position,
			    vPadding: innerBubbleStyle.exportStyle.offset.dy,
			    hPadding: innerBubbleStyle.exportStyle.offset.dx,
			    color: innerBubbleStyle.exportStyle.backgroundColor,
		    ),
		    BubbleView(
			    size: (innerBubbleStyle.exportStyle.height / 2) * innerBubbleStyle.exportStyle.scale,
			    position: position,
			    vPadding: 8,
			    hPadding: 0,
			    color: innerBubbleStyle.exportStyle.backgroundColor,
		    ),
	    ],
    ),);
  }
}

class Bubble extends StatefulWidget {
	final double mainBubbleSize;
	final double innerBubbleSize;
	final ScrollController scrollController;
	final Duration delayedDuration;
	final BubblePosition position;
	final double horizontalOffset;
	final double verticalOffset;
	final Color color;
	final bool enableAnimation;
	Bubble(
			{Key key,
				this.mainBubbleSize = 250,
				this.innerBubbleSize = 100,
				this.scrollController,
				this.delayedDuration,
				this.position = BubblePosition.TopRight,
				this.horizontalOffset = -150,
				this.verticalOffset = -100, this.color = Colors.blue, this.enableAnimation = true})
			: super(key: key);

	@override
	_BubbleDecorationState createState() => _BubbleDecorationState();
}

class _BubbleDecorationState extends State<Bubble> {


	Size mainBubbleSize;
	Size innerBubbleSize;
	Size accentBubble;
	double get originalMain => widget.mainBubbleSize;
	double get originalAccent => widget.innerBubbleSize / 2;
	double get originalInner => widget.innerBubbleSize;

	ScrollController get scrollController => widget.scrollController ?? ScrollController();
	double opacity = 0.0;
	BubblePosition get position => widget.position;




	@override
	void initState() {
		super.initState();

		mainBubbleSize = Size(widget.mainBubbleSize, widget.mainBubbleSize);
		innerBubbleSize = Size(widget.innerBubbleSize, widget.innerBubbleSize);
		accentBubble = Size(widget.innerBubbleSize / 2, widget.innerBubbleSize / 2);
		if(widget.enableAnimation){
			scrollController.addListener(() {
				scrollListener(scrollController.offset);
			});
			if (widget.delayedDuration != null) {
				Future.delayed(widget.delayedDuration, () {
					setState(() {
						opacity = 1.0;
					});
				});
			} else {
				setState(() {
					opacity = 1.0;
				});
			}
		}

	}

	@override
	Widget build(BuildContext context) {

		return AnimatedOpacity(
			duration: Duration(milliseconds: 200),
			opacity: opacity,
			child: Stack(
				children: <Widget>[
					BubbleView(
						size: mainBubbleSize.height,
						position: position,
						vPadding: widget.verticalOffset,
						hPadding: widget.horizontalOffset,
						color: widget.color,
					),
					BubbleView(
						size: innerBubbleSize.height,
						position: position,
						vPadding: widget.innerBubbleSize,
						hPadding: widget.innerBubbleSize,
						color: widget.color,
					),
					BubbleView(
						size: (innerBubbleSize / 2).height,
						position: position,
						vPadding: 8,
						hPadding: 0,
						color: widget.color,
					),
				],
			),
		);
	}

	scrollListener(double offset){
		if (offset >= 200) {
			if (mainBubbleSize.height != 0.0) {
				setState(() {
					mainBubbleSize = Size(0, 0);
					innerBubbleSize = Size(0, 0);
					accentBubble = Size(0, 0);
				});
			}
		} else if (offset <= 50 && offset >= 0) {
			if (mainBubbleSize.height != originalMain) {
				setState(() {
					mainBubbleSize = Size(originalMain, originalMain);
					innerBubbleSize = Size(originalInner, originalInner);
					accentBubble = Size(originalAccent, originalAccent);
				});
			}
		}
	}
}