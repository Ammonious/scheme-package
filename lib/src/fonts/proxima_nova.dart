import 'package:flutter/material.dart';
import 'package:scheme_theme/scheme_theme.dart';



class ProximaNova {
  static const String black = "Proxima Black";
  static const String extra_bold = "Proxima Extra Bold";
  static const String bold = "Proxima Bold";
  static const String semi_bold = "Proxima Semi Bold";
  static const String regular = "Proxima Regular";
  static const String light = "Proxima Light";
}

class SofiaPro {

  static const String sofia_pro = "Sophia Pro";
}

class Assets {
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/proxima_nova_black.otf)
  static const String proximaNovaBlack = "fonts/proxima_nova_black.otf";
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/proxima_nova_bold.otf)
  static const String proximaNovaBold = "fonts/proxima_nova_bold.otf";
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/proxima_nova_bold_italic.otf)
  static const String proximaNovaBoldItalic = "fonts/proxima_nova_bold_italic.otf";
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/proxima_nova_cond_light.otf)
  static const String proximaNovaCondLight = "fonts/proxima_nova_cond_light.otf";
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/proxima_nova_cond_light_italic.otf)
  static const String proximaNovaCondLightItalic = "fonts/proxima_nova_cond_light_italic.otf";
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/proxima_nova_cond_regular.otf)
  static const String proximaNovaCondRegular = "fonts/proxima_nova_cond_regular.otf";
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/proxima_nova_cond_regular_italic.otf)
  static const String proximaNovaCondRegularItalic = "fonts/proxima_nova_cond_regular_italic.otf";
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/proxima_nova_cond_semi_bold.otf)
  static const String proximaNovaCondSemiBold = "fonts/proxima_nova_cond_semi_bold.otf";
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/proxima_nova_cond_semi_bold_italic.otf)
  static const String proximaNovaCondSemiBoldItalic = "fonts/proxima_nova_cond_semi_bold_italic.otf";
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/proxima_nova_extra_bold.otf)
  static const String proximaNovaExtraBold = "fonts/proxima_nova_extra_bold.otf";
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/proxima_nova_light.otf)
  static const String proximaNovaLight = "fonts/proxima_nova_light.otf";
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/proxima_nova_light_italic.otf)
  static const String proximaNovaLightItalic = "fonts/proxima_nova_light_italic.otf";
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/proxima_nova_regular.otf)
  static const String proximaNovaRegular = "fonts/proxima_nova_regular.otf";
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/proxima_nova_regular_italic.otf)
  static const String proximaNovaRegularItalic = "fonts/proxima_nova_regular_italic.otf";
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/proxima_nova_semi_bold.otf)
  static const String proximaNovaSemiBold = "fonts/proxima_nova_semi_bold.otf";
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/proxima_nova_semi_bold_italic.otf)
  static const String proximaNovaSemiBoldItalic = "fonts/proxima_nova_semi_bold_italic.otf";
  /// ![](file:///Users/ammonrees/Scheme%20Development/Flutter%20Projects/active_lifestyle/fonts/sofia_pro_light.otf)
  static const String sofiaProLight = "fonts/sofia_pro_light.otf";
}


const   _thin = FontWeight.w100;
const  _extraLight = FontWeight.w200;
const  _light = FontWeight.w300;
const _regular = FontWeight.w400;
const _medium = FontWeight.w500;
const _semiBold = FontWeight.w600;
const _bold = FontWeight.w700;
const _extraBold = FontWeight.w800;
const _black = FontWeight.w900;

 const TextStyle proxima_headline1 = TextStyle(fontFamily: ProximaNova.bold,
    fontSize: 96, fontWeight: _bold,color: nearlyBlack, letterSpacing: -1.5);

const TextStyle proxima_headline2 = TextStyle(fontFamily: ProximaNova.bold,
    fontSize: 60, fontWeight: _bold,color: nearlyBlack, letterSpacing: -0.5);

const TextStyle proxima_headline3 = TextStyle(fontFamily: ProximaNova.bold,
    fontSize: 48, fontWeight: _bold,color: nearlyBlack, letterSpacing: 0);

const TextStyle proxima_headline4 = TextStyle(fontFamily: ProximaNova.semi_bold,
    fontSize: 34, fontWeight: _bold, color: nearlyBlack, letterSpacing: 1.25);

const TextStyle proxima_headline5 = TextStyle(fontFamily: ProximaNova.semi_bold,
    fontSize: 24, fontWeight: _bold,color: nearlyBlack, letterSpacing: 0);

const TextStyle proxima_headline6 = TextStyle(fontFamily: ProximaNova.semi_bold,
    fontSize: 20,
    fontWeight: _medium,color: nearlyBlack, letterSpacing: 1.25);

const TextStyle proxima_body1 =  TextStyle(fontFamily: ProximaNova.regular,
    fontSize: 18,
    fontWeight: _regular,color: nearlyBlack, letterSpacing: 1.5);

const TextStyle proxima_body2 = TextStyle(fontFamily: ProximaNova.regular,
    fontSize: 15,
    fontWeight: _regular,color: nearlyBlack, letterSpacing: 1.25);

const TextStyle proxima_subtitle1 = TextStyle(fontFamily: ProximaNova.semi_bold,
    fontSize: 18,
    fontWeight: _medium,color: nearlyBlack, letterSpacing: 1.15);

const TextStyle proxima_subtitle2 = TextStyle(fontFamily: ProximaNova.semi_bold,
    fontSize: 15,
    fontWeight: _medium,color: nearlyBlack, letterSpacing: 1.1);

const TextStyle proxima_button = TextStyle(fontFamily: ProximaNova.semi_bold,
    fontSize: 15,
    fontWeight: _semiBold,color: nearlyBlack, letterSpacing: 1.25);

const TextStyle proxima_caption = TextStyle(fontFamily: ProximaNova.regular,
    fontSize: 12,
    fontWeight: _regular,color: nearlyBlack, letterSpacing: 1.4);

const TextStyle proxima_overline = TextStyle(fontFamily: ProximaNova.regular,color: nearlyBlack, letterSpacing: 3);

