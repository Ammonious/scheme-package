import 'dart:math';

import 'package:flutter/material.dart';
import 'package:color/color.dart' as color;

extension StringToColor on String {

	Color get toColor => HexColor(this);

}

extension ColorHexString on Color {

	String get hexString => this == null ? Colors.blue.value.toRadixString(16).substring(2, this.value.toRadixString(16).length) : this.value.toRadixString(16).substring(2, this.value.toRadixString(16).length);

	Color get shade50 => SmartColor.antDColor(this).shade50;
	Color get shade100 => SmartColor.antDColor(this).shade100;
	Color get shade200 => SmartColor.antDColor(this).shade200;
	Color get shade300 => SmartColor.antDColor(this).shade300;
	Color get shade400 => SmartColor.antDColor(this).shade400;
	Color get shade500 => SmartColor.antDColor(this).shade500;
	Color get shade600 => SmartColor.antDColor(this).shade600;
	Color get shade700 => SmartColor.antDColor(this).shade700;
	Color get shade800 =>  SmartColor.antDColor(this).shade800;
	Color get shade900 => SmartColor.antDColor(this).shade900;
	Color get compColor => CompColor(this.hexString);
	Color get textColor => TextColor(this);


}

class SmartColor {
	static Color parse(String color) => _getColor(color);


	static bool suitAntDesign(Color color){
		HSLColor hslColor = HSLColor.fromColor(color);
		return hslColor.lightness*100 >= 70 && hslColor.saturation*100 >=70;
	}

	static DesignColor antDColor(Color color) {
		Map<int, Color> colors = Map<int, Color>();
		for (int i = 1; i <= 10; i++) {
			colors[i] = SmartColor._makeAntDColor(color, i);
		}
		return DesignColor(color.value, colors);
	}

	static Color _makeAntDColor(Color color, int index) {
		bool isLight = index <= 6;
		HSVColor hsv = HSVColor.fromColor(color);
		int lightColorCount = 5;
		var i = isLight ? lightColorCount + 1 - index : index - lightColorCount - 1;
		return HSVColor.fromAHSV(
			1,
			_getHue(hsv, i, isLight),
			_getSaturation(hsv, i, isLight),
			_getValue(hsv, i, isLight),
		).toColor();
	}

	static _getColor(String color) {
		Color rgbaColor = _getRGBAColorFromString(color);
		if (rgbaColor != null) {
			return rgbaColor;
		}
		return HexColor(color);
	}

	static Color _getRGBAColorFromString(String string) {
		string = string.replaceAll(" ", ""); // pseudo-trimming
		if (string.startsWith("rgba(") && string.endsWith(")")) {
			// Correct
			string = string.replaceAll("rgba(", "");
			string = string.replaceAll(")", "");
			List<String> rgba = string.split(",");
			if (rgba.length == 4) {
				int r = int.parse(rgba[0]);
				int g = int.parse(rgba[1]);
				int b = int.parse(rgba[2]);
				double a = double.parse(rgba[3]) * 255;
				return new Color.fromARGB(a.toInt(), r, g, b);
			}
			return null;
		}
		return null;
	}

}

class DesignColor extends ColorSwatch<int> {
	const DesignColor(int primary, Map<int, Color> swatch)
			: super(primary, swatch);
	Color get shade50 => this[1];
	Color get shade100 => this[2];
	Color get shade200 => this[3];
	Color get shade300 => this[4];
	Color get shade400 => this[5];
	Color get shade500 => this[6];
	Color get shade600 => this[7];
	Color get shade700 => this[8];
	Color get shade800 => this[9];
	Color get shade900 => this[10];
}

class HexColor extends Color {
	static int _getColorFromHex(String hexColor) {
		if(hexColor == null) hexColor = Colors.white.hexString;

		hexColor = hexColor.toUpperCase().replaceAll("#", "");
		if (hexColor.length == 6) {
			hexColor = "FF" + hexColor;
		}
		return int.parse(hexColor, radix: 16);
	}

	HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}



class TextColor extends Color {
	static int _getBrandColorFromString(Color backgroundColor) {

		HexColor hex = HexColor(backgroundColor.hexString);

		int d = 0;
		double luminance = (0.299 * hex.red + 0.587 * hex.green + 0.114 * hex.blue) / 255;
		if(luminance > 0.5){
			d = 0;
		} else {
			d = 255;
		}
		color.RgbColor shadedRGB = color.RgbColor(d,d,d);
		color.HexColor convertedRGB = shadedRGB.toHexColor();
		String shadedHex = convertedRGB.toString().toUpperCase().replaceAll("#", "");
		if (shadedHex.length == 6) {
			shadedHex = "FF" + shadedHex;
		}
		return int.parse(shadedHex, radix: 16);
	}

	TextColor(final Color backgroundColor) : super(_getBrandColorFromString(backgroundColor));
}

///getHue
double _getHue(HSVColor hsv, int i, bool isLight) {
	double hue;
	int hueStep = 2;
	if (hsv.hue >= 60 && hsv.hue <= 240) {
		hue = isLight == true ? hsv.hue - hueStep * i : hsv.hue + hueStep * i;
	} else {
		hue = isLight == true ? hsv.hue + hueStep * i : hsv.hue - hueStep * i;
	}
	if (hue < 0) {
		hue += 360;
	} else if (hue >= 360) {
		hue -= 360;
	}
	return hue.round().toDouble();
}

///getSaturation
double _getSaturation(HSVColor hsv, int i, bool isLight) {
	int saturation;
	int saturationStep = 16;
	int saturationStep2 = 5;
	int darkColorCount = 4;
	var lightColorCount = 5;
	if (isLight == true) {
		saturation = (hsv.saturation * 100).round() - saturationStep * i;
	} else if (i == darkColorCount) {
		saturation = (hsv.saturation * 100).round() + saturationStep;
	} else {
		saturation = (hsv.saturation * 100).round() + saturationStep2 * i;
	}
	if (saturation > 100) {
		saturation = 100;
	}
	if (isLight == true && i == lightColorCount && saturation > 10) {
		saturation = 10;
	}
	if (saturation < 6) {
		saturation = 6;
	}
	return saturation.toDouble() / 100;
}

/// getValue
double _getValue(HSVColor hsv, int i, bool isLight) {
	int brightnessStep1 = 5;
	int brightnessStep2 = 15;
	if (isLight == true) {
		return (((hsv.value * 100).round() + brightnessStep1 * i) > 100
				? 100
				: ((hsv.value * 100).round() + brightnessStep1 * i))
				.toDouble() /
				100;
	}
	return ((hsv.value * 100).round() - brightnessStep2 * i).toDouble() / 100;
}


class CompColor extends Color {
	static int _hexToComplimentary(String colorString) {

		color.HexColor hex = color.HexColor(colorString);
		color.RgbColor rgb = hex.toRgbColor();
		var r = (rgb.r / 255);
		var g = (rgb.g / 255);
		var b = (rgb.b / 255);
		var mx =  [r,g,b].reduce(max);
		var mn = [r,g,b].reduce(min);

		var h = (mx + mn) / 2.0;
		var s = (mx + mn) / 2.0;
		var l = (mx + mn) / 2.0;
		if(mx == mn) {
			h = s = 0;  //achromatic
		} else {
			var d = mx - mn;
			s = (l > 0.5 ? d / (2.0 - mx - mn) : d / (mx + mn));

			if(mx == r && g >= b) {
				h = 1.0472 * (g - b) / d ;
			} else if(mx == r && g < b) {
				h = 1.0472 * (g - b) / d + 6.2832;
			} else if(mx == g) {
				h = 1.0472 * (b - r) / d + 2.0944;
			} else if(mx == b) {
				h = 1.0472 * (r - g) / d + 4.1888;
			}
		}

		h = h / 6.2832 * 360.0 + 0;

		h+= 180;
		if (h > 360) { h -= 360; }
		h /= 360;

		if(s == 0){
			r = g = b = l; // achromatic
		} else {

			var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
			var p = 2 * l - q;

			r = hue2rgb(p, q, h + 1/3);
			g = hue2rgb(p, q, h);
			b = hue2rgb(p, q, h - 1/3);
		}

		int R = (r * 255).round();
		int G = (g * 255).round();
		int B = (b * 255).round();

		color.RgbColor compRGB = color.RgbColor(R,G,B);
		color.HexColor convertedRGB = compRGB.toHexColor();
		String compHex = convertedRGB.toString().toUpperCase().replaceAll("#", "");
		if (compHex.length == 6) {
			compHex = "FF" + compHex;
		}
		return int.parse(compHex, radix: 16);
	}

	static hue2rgb(var p, var q, var t) {
		if (t < 0)
			t += 1;
		if (t > 1)
			t -= 1;
		if (t < 1/6)
			return p + (q - p) * 6 * t;
		if (t < 1/2)
			return q;
		if (t < 2/3)
			return p + (q - p) * (2/3 - t) * 6;
		return p;
	}

	CompColor(final String hexColor) : super(_hexToComplimentary(hexColor));
}