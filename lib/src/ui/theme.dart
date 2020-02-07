import 'package:flutter/material.dart';
import 'package:scheme_package/src/utils/color_tools.dart';
import 'package:scheme_package/src/utils/constants.dart';
import 'package:scheme_package/src/ui/styles.dart';



class Theme {
	static const _lightFillColor = Colors.black;
	static const _darkFillColor = Colors.white;

	static Color _lightFocusColor = Colors.black.withOpacity(0.12);
	static Color _darkFocusColor = Colors.white.withOpacity(0.12);
	static Color _themeColor;
	static ThemeData lightThemeData =
	themeData(_lightColorScheme, _lightFocusColor,_themeColor);
	static ThemeData darkThemeData = themeData(_darkColorScheme, _darkFocusColor,_themeColor);

	static ThemeData themeData(ColorScheme colorScheme, Color focusColor,Color themeColor) {
		return ThemeData(
			colorScheme: colorScheme,
			textTheme: _textTheme,
			appBarTheme: AppBarTheme(
				textTheme: _textTheme.apply(bodyColor: colorScheme.onPrimary),
				color: colorScheme.background,
				elevation: 0,
				iconTheme: IconThemeData(color: colorScheme.primary),
				brightness: colorScheme.brightness,
			),
			iconTheme: IconThemeData(color: colorScheme.onPrimary),
			canvasColor: colorScheme.background,
			scaffoldBackgroundColor: colorScheme.background,
			highlightColor: Colors.transparent,
			accentColor: colorScheme.primary,
			focusColor: focusColor,
			snackBarTheme: SnackBarThemeData(
				behavior: SnackBarBehavior.floating,
				backgroundColor: Color.alphaBlend(
					_lightFillColor.withOpacity(0.80),
					_darkFillColor,
				),
				contentTextStyle: _textTheme.subhead.apply(color: _darkFillColor),
			),
		);
	}

	static ColorScheme _lightColorScheme = ColorScheme(
		primary: _themeColor,
		primaryVariant: _themeColor.compColor,
		secondary: background,
		secondaryVariant: nearlyWhite,
		background: background,
		surface: nearlyWhite,
		onBackground: Colors.white,
		error: _lightFillColor,
		onError: _lightFillColor,
		onPrimary: _lightFillColor,
		onSecondary: const Color(0xFF322942),
		onSurface: const Color(0xFF241E30),
		brightness: Brightness.light,
	);

	static ColorScheme _darkColorScheme = ColorScheme(
		primary: _themeColor,
		primaryVariant: _themeColor.compColor,
		secondary: _themeColor.shade700,
		secondaryVariant: _themeColor.shade800,
		background: darkBackground,
		surface: darkBackground,
		onBackground: Colors.white.withOpacity(0.05),
		error: _darkFillColor,
		onError: _darkFillColor,
		onPrimary: _darkFillColor,
		onSecondary: _darkFillColor,
		onSurface: _darkFillColor,
		brightness: Brightness.dark,
	);

	static TextTheme _textTheme = TextTheme(
		display1: h5,
		caption: caption,
		headline: h2,
		subhead: h4,
		overline: overline,
		body2: body2,
		subtitle: subtitle1,
		body1: body1,
		title: h6,
		button: button,
	);
}
