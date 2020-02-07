
import 'package:flutter/material.dart';
import 'package:scheme_package/utils/constants.dart';

import 'bubble_view.dart';

enum BubblePosition { TopRight, TopLeft, BottomRight, BottomLeft }

class BubbleDecoration extends StatefulWidget {
	final double mainBubbleSize;
	final double innerBubbleSize;
	final ScrollController scrollController;
	final Duration delayedDuration;
	final BubblePosition position;
	final double horizontalOffset;
	final double verticalOffset;
	final Color color;
	BubbleDecoration(
			{Key key,
				this.mainBubbleSize = 250,
				this.innerBubbleSize = 100,
				this.scrollController,
				this.delayedDuration,
				this.position = BubblePosition.TopRight,
				this.horizontalOffset = -150,
				this.verticalOffset = -100, this.color = Colors.blue})
			: super(key: key);

	@override
	_BubbleDecorationState createState() => _BubbleDecorationState();
}

class _BubbleDecorationState extends State<BubbleDecoration> {


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

	@override
	Widget build(BuildContext context) {

		return AnimatedOpacity(
			duration: normalDuration,
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

	isTop() {
		switch (position) {
			case BubblePosition.TopRight:
				return true;
			case BubblePosition.TopLeft:
				return true;
			case BubblePosition.BottomRight:
				return false;
			case BubblePosition.BottomLeft:
				return false;
		}
	}

	isBottom() {
		switch (position) {
			case BubblePosition.TopRight:
				return false;
			case BubblePosition.TopLeft:
				return false;
			case BubblePosition.BottomRight:
				return true;
			case BubblePosition.BottomLeft:
				return true;
		}
	}

	isRight() {
		switch (position) {
			case BubblePosition.TopRight:
				return true;
			case BubblePosition.TopLeft:
				return false;
			case BubblePosition.BottomRight:
				return true;
			case BubblePosition.BottomLeft:
				return false;
		}
	}

	isLeft() {
		switch (position) {
			case BubblePosition.TopRight:
				return false;
			case BubblePosition.TopLeft:
				return true;
			case BubblePosition.BottomRight:
				return false;
			case BubblePosition.BottomLeft:
				return true;
		}
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