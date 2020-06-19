import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:scheme_package/src/buttons/scheme_button.dart';
import 'package:scheme_package/src/forms/form_constants.dart';
import 'package:scheme_package/src/navigation/model/nav_data.dart';
import 'package:scheme_package/src/textfields/scheme_field_decoration.dart';
import 'package:scheme_package/src/theme/theme_model.dart';
import 'package:scheme_package/src/theme/theme_provider_model.dart';
import 'package:scheme_theme/scheme_theme.dart';

@lazySingleton
class SchemeTheme {
  buildTheme(
      ThemeModel themeModel, ThemeProviderModel providerModel, bool isDark) {
    _themeModel = themeModel;
    _model = providerModel;
    _data = isDark ? themeModel.schemeDark : themeModel.schemeLight;
    _schemeButtonStyle = model.buttonTheme;
    _schemeFieldStyle = model.fieldTheme;
    _schemeBarStyle = model.bottomBarTheme;
    return _data;
  }

  Color get themeColor => _data != null ? _data.primaryColor : _fallbackTheme;

  Color get accentColor => _data != null ? _data.accentColor : _fallbackAccent;

  Color _fallbackTheme = Colors.blueAccent.shade700;

  Color _fallbackAccent = Color(0xFFf9ff21);

  SchemeButtonStyle _schemeButtonStyle;
  SchemeBarStyle _schemeBarStyle;
  SchemeFieldStyle _schemeFieldStyle;

  ThemeProviderModel get model => _model;
  ThemeProviderModel _model;

  ThemeModel get themeModel => _themeModel;
  ThemeModel _themeModel;

  ThemeData get data => _data;
  ThemeData _data;

  // ignore: slash_for_doc_comments
  /********************************
   * ? Getters
   *********************************/


  SchemeButtonStyle get schemeButtonStyle => _schemeButtonStyle;

  SchemeBarStyle get schemeBarStyle => _schemeBarStyle;

  SchemeFieldStyle get schemeFieldStyle => _schemeFieldStyle;

  get mobileCardRadius => BorderRadius.only(
      topLeft: Radius.circular(24), topRight: Radius.circular(24));

  get desktopCardRadius => BorderRadius.only(topLeft: Radius.circular(24));

  get cardRadius => _themeModel.cardRadius;

  get topCardRadius => BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      );

  get buttonRadius => _themeModel.buttonRadius;

  get textFieldDecoration => SchemeFieldDecoration(
        cardColor: _data.cardColor,
        boxShadow: normalShadow,
        height: smallPhone(h) ? 62 : 72,
        textStyle: _data.textTheme.subtitle1
            .copyWith(fontSize: smallPhone(h) ? 14 : 16,color: _data.cardColor.textColor),
      );

  TextTheme get textTheme => _data.textTheme;

  /// [Colors]
  LinearGradient get themeGradient =>
      schemeGradient(color: themeColor ?? _fallbackTheme);

  Color get canvasColor => _data.canvasColor ?? Colors.white;

  Color get cardColor => _data.cardColor ?? Colors.white;

  Color get barColor => _data.bottomAppBarColor ?? Colors.white;

  Color get secondaryCardColor => _data.secondaryHeaderColor ?? Colors.white;

  Color get textColor => _data.textTheme.headline6.color;

  Color get lightBrand => themeColor.shade200;

  Color get iconColor => themeColor.shade700.textColor;

  String get logo => _data.brightness == Brightness.light
      ? 'assets/logo_light.png'
      : 'assets/logo_dark.png';

  TextStyle get bar_button => _data.textTheme.button;

  /// TextStyle with [TextColor] set to [themeColor].
  TextStyle get flat_button =>
      _data.textTheme.button.copyWith(color: themeColor);

  /// TextStyle with adaptive [Color] set to [TextColor] [shade700].
  TextStyle get button_gradient =>
      _data.textTheme.button.copyWith(color: themeColor.shade700.textColor);

  TextStyle get number =>
      GoogleFonts.anton(color: themeColor.shade700.textColor, fontSize: 20);

  TextStyle get subtitle1 => _data.textTheme.subtitle1.copyWith(color: _data.canvasColor.textColor);

  TextStyle get subtitle2 => _data.textTheme.subtitle2.copyWith(color: _data.canvasColor.textColor);

  TextStyle get bodyText1 => _data.textTheme.bodyText1.copyWith(color: _data.canvasColor.textColor);

  TextStyle get bodyText2 => _data.textTheme.bodyText2.copyWith(color: _data.canvasColor.textColor);

  TextStyle get headline1 => _data.textTheme.headline1.copyWith(color: _data.canvasColor.textColor);

  TextStyle get headline2 => _data.textTheme.headline2.copyWith(color: _data.canvasColor.textColor);

  TextStyle get headline3 => _data.textTheme.headline3.copyWith(color: _data.canvasColor.textColor);

  TextStyle get headline4 => _data.textTheme.headline4.copyWith(color: _data.canvasColor.textColor);

  TextStyle get headline5 => _data.textTheme.headline5.copyWith(color: _data.canvasColor.textColor);

  TextStyle get headline6 => _data.textTheme.headline6.copyWith(color: _data.canvasColor.textColor);

  TextStyle get overline => _data.textTheme.overline.copyWith(color: _data.canvasColor.textColor);

  TextStyle get caption => _data.textTheme.caption.copyWith(color: _data.canvasColor.textColor.withOpacity(0.75));

  TextStyle get title =>
      _data.textTheme.subtitle1.copyWith(color: barColor.textColor);
}

double get w => ScreenUtil.screenWidthDp;

double get h => ScreenUtil.screenHeightDp;
