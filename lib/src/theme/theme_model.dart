import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/theme/theme_provider_model.dart';
import 'package:scheme_theme/scheme_theme.dart';

class ThemeModel {
  final Color themeColor;
  final Color accentColor;
  final Color barColor;
  final Color cardColor;
  final Color canvasColor;
  final Color darkCanvas;
  final Color textColor;
  final Color hintColor;
  final TextTheme textThemeLight;
  final TextTheme textThemeDark;
  final BorderRadius cardRadius;
  final BorderRadius buttonRadius;
  final Stream<ThemeProviderModel> stream;

  ThemeModel({
     @required this.themeColor,
    @required  this.accentColor,
      this.barColor,
      this.cardColor,
      this.canvasColor,
      this.textColor,
      this.textThemeLight,
      this.textThemeDark,
      this.cardRadius,
      this.buttonRadius,
      this.hintColor,
      this.darkCanvas, 
      @required this.stream});

  /// Default [Color] Values.
  Color get _defaultTextColor => Color(0xFF213333);

  Color get _textColorDarkTheme => Color(0xFFFFFFFF);

  Color get _themeColor => themeColor ?? Colors.blueAccent.shade700;

  Color get _accentColor => accentColor ?? Colors.yellowAccent.shade700;

  Color get _barColor => barColor ?? Color(0xFFFFFFFF);

  Color get _cardColor => cardColor ?? Color(0xFFFFFFFF);

  Color get _canvasColor => canvasColor ?? neuBackground;

  Color get _darkColor => darkCanvas ?? Color(0xFF121212);

  Color get _hintColor => Colors.grey.shade600;

  StreamProvider<ThemeProviderModel> get streamProvider =>  StreamProvider.value(value:stream);

  TextTheme get _textThemeLight => textThemeLight ?? _fallbackLightTextTheme;

  TextTheme get _textThemeDark => textThemeDark ?? _fallbackDarkTextTheme;

  BorderRadius get _cardRadius => cardRadius ?? BorderRadius.circular(16);

  BorderRadius get _buttonRadius => buttonRadius ?? BorderRadius.circular(8);

  ThemeData get schemeLight => _schemeTheme(false);

  ThemeData get schemeDark => _schemeTheme(true);

  ThemeData _schemeTheme(bool isDark) {
    TextTheme textTheme = isDark ? _textThemeDark : _textThemeLight;
    Color backgroundColor = isDark ? _darkColor : _canvasColor;
    return ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: _themeColor,
        brightness: isDark ? Brightness.dark : Brightness.light,
        accentColor: _accentColor,
        textSelectionHandleColor: _themeColor,
        textTheme: textTheme,
        primaryColorLight: _themeColor,
        primaryColorDark: _themeColor.darkenBy(10),
        secondaryHeaderColor:
            isDark ? backgroundColor.lightenBy(10) : _cardColor,
        selectedRowColor: _themeColor.withOpacity(0.25),
        navigationRailTheme: NavigationRailThemeData(
            unselectedLabelTextStyle: textTheme.subtitle2
                .copyWith(color: _hintColor, fontWeight: FontWeight.w500),
            selectedLabelTextStyle: textTheme.subtitle2
                .copyWith(color: _themeColor, fontWeight: FontWeight.w800)),
        accentTextTheme: textTheme.copyWith(button: _btn),
        hintColor: _hintColor,
        canvasColor: backgroundColor,
        bottomAppBarColor: isDark ? backgroundColor.lightenBy(15) : _barColor,
        iconTheme: IconThemeData(color: _defaultTextColor),
        cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
          borderRadius: _cardRadius,
        )),
        buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(borderRadius: _buttonRadius)),
        cardColor: isDark ? backgroundColor.lightenBy(10) : cardColor);
  }

  TextTheme get _fallbackDarkTextTheme => TextTheme(
        headline1: _h1.copyWith(color: _textColorDarkTheme),
        headline2: _h2.copyWith(color: _textColorDarkTheme),
        headline3: _h3.copyWith(color: _textColorDarkTheme),
        headline4: _h4.copyWith(color: _textColorDarkTheme),
        headline5: _h5.copyWith(color: _textColorDarkTheme),
        headline6: _h6.copyWith(color: _textColorDarkTheme),
        bodyText1: _b1.copyWith(color: _textColorDarkTheme),
        bodyText2: _b2.copyWith(color: _textColorDarkTheme),
        subtitle1: _s1.copyWith(color: _textColorDarkTheme),
        subtitle2: _s2.copyWith(color: _textColorDarkTheme),
        caption: _cptn.copyWith(color: _textColorDarkTheme),
        button: _btn.copyWith(color: _textColorDarkTheme),
        overline: _over.copyWith(color: _textColorDarkTheme),
      );

  TextTheme get _fallbackLightTextTheme => TextTheme(
        headline1: _h1.copyWith(color: _defaultTextColor),
        headline2: _h2.copyWith(color: _defaultTextColor),
        headline3: _h3.copyWith(color: _defaultTextColor),
        headline4: _h4.copyWith(color: _defaultTextColor),
        headline5: _h5.copyWith(color: _defaultTextColor),
        headline6: _h6.copyWith(color: _defaultTextColor),
        bodyText1: _b1.copyWith(color: _defaultTextColor),
        bodyText2: _b2.copyWith(color: _defaultTextColor),
        subtitle1: _s1.copyWith(color: _defaultTextColor),
        subtitle2: _s2.copyWith(color: _defaultTextColor),
        caption: _cptn.copyWith(color: Colors.grey.shade700),
        button: _btn.copyWith(color: _defaultTextColor),
        overline: _over.copyWith(color: _defaultTextColor),
      );

  final _thin = FontWeight.w100;
  final _extraLight = FontWeight.w200;
  final _light = FontWeight.w300;
  final _regular = FontWeight.w400;
  final _medium = FontWeight.w500;
  final _semiBold = FontWeight.w600;
  final _bold = FontWeight.w700;
  final _extraBold = FontWeight.w800;
  final _black = FontWeight.w900;

  TextStyle get _h1 => GoogleFonts.rubikMonoOne(
      fontSize: 73,
      fontWeight: _light,
      textStyle: TextStyle(color: _defaultTextColor, letterSpacing: -1.5));

  TextStyle get _h2 => GoogleFonts.rubikMonoOne(
      fontSize: 46,
      fontWeight: _light,
      textStyle: TextStyle(color: _defaultTextColor, letterSpacing: -0.5));

  TextStyle get _h3 => GoogleFonts.rubikMonoOne(
      fontSize: 36,
      fontWeight: _regular,
      textStyle: TextStyle(color: _defaultTextColor, letterSpacing: 0.0));

  TextStyle get _h4 => GoogleFonts.rubikMonoOne(
      fontSize: 26,
      fontWeight: _regular,
      textStyle: TextStyle(color: _defaultTextColor, letterSpacing: 0.25));

  TextStyle get _h5 => GoogleFonts.rubikMonoOne(
      fontSize: 22,
      fontWeight: _regular,
      textStyle: TextStyle(color: _defaultTextColor, letterSpacing: 0));

  TextStyle get _h6 => GoogleFonts.rubik(
      fontSize: 18,
      fontWeight: _bold,
      textStyle: TextStyle(color: _defaultTextColor, letterSpacing: 0.15));

  TextStyle get _b1 => GoogleFonts.rubik(
      fontSize: 16,
      fontWeight: _regular,
      textStyle: TextStyle(color: _defaultTextColor, letterSpacing: 0.5));

  TextStyle get _b2 => GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: _regular,
      textStyle: TextStyle(color: _defaultTextColor, letterSpacing: 0.25));

  TextStyle get _s1 => GoogleFonts.rubik(
      fontSize: 16,
      fontWeight: _regular,
      textStyle: TextStyle(color: _defaultTextColor, letterSpacing: 0.15));

  TextStyle get _s2 => GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: _medium,
      textStyle: TextStyle(color: _defaultTextColor, letterSpacing: 0.1));

  TextStyle get _btn => GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: _medium,
      textStyle: TextStyle(color: _defaultTextColor, letterSpacing: 1.25));

  TextStyle get _cptn => GoogleFonts.rubik(
      fontSize: 12,
      fontWeight: _regular,
      textStyle: TextStyle(color: _defaultTextColor, letterSpacing: 0.4));

  TextStyle get _over => GoogleFonts.rubik(
      fontSize: 10,
      fontWeight: _regular,
      textStyle: TextStyle(color: _defaultTextColor, letterSpacing: 1.5));
}
