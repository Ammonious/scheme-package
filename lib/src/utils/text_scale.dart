import 'dart:math';

import 'package:flutter/material.dart';

// Sentinel value for the system text scale factor option.
const double systemTextScaleFactorOption = -1;

double _textScaleFactor(BuildContext context) {
	return textScaleFactor(context);
}

// When text is larger, this factor becomes larger, but at half the rate.
//
// | Text scaling | Text scale factor | reducedTextScale(context) |
// |--------------|-------------------|---------------------------|
// | Small        |               0.8 |                       1.0 |
// | Normal       |               1.0 |                       1.0 |
// | Large        |               2.0 |                       1.5 |
// | Huge         |               3.0 |                       2.0 |

double reducedTextScale(BuildContext context) {
	double textScaleFactor = _textScaleFactor(context);
	return textScaleFactor >= 1 ? (1 + textScaleFactor) / 2 : 1;
}

// When text is larger, this factor becomes larger at the same rate.
// But when text is smaller, this factor stays at 1.
//
// | Text scaling | Text scale factor |  cappedTextScale(context) |
// |--------------|-------------------|---------------------------|
// | Small        |               0.8 |                       1.0 |
// | Normal       |               1.0 |                       1.0 |
// | Large        |               2.0 |                       2.0 |
// | Huge         |               3.0 |                       3.0 |

double cappedTextScale(BuildContext context) {
	double textScaleFactor = _textScaleFactor(context);
	return max(textScaleFactor, 1);
}

double textScaleFactor(BuildContext context, {bool useSentinel = false}) {
	if (_textScaleFactor == systemTextScaleFactorOption) {
		return useSentinel
				? systemTextScaleFactorOption
				: MediaQuery.of(context).textScaleFactor;
	} else {
	//	return _textScaleFactor;
	}
}