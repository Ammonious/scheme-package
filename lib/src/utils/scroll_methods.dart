
import 'package:flutter/material.dart';

opacityOnScroll(
		{ScrollController scrollController, double opacity, Function(double opacity) onRefresh}) {
	if (scrollController.offset >= 75) {
		if (opacity != 1) {
			opacity = 1;
			onRefresh(opacity);
		}
	} else if (scrollController.offset <= 75 && scrollController.offset >= 0) {
		if (opacity != 0.75) {
			opacity = 0.75;
			onRefresh(opacity);
		}
	} else if (scrollController.offset <= 0) {
		if (opacity != 0.75) {
			opacity = 0.75;
			onRefresh(opacity);
		}
	}
}