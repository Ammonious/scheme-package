

 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheme_theme/scheme_theme.dart';
import '../utils/constants.dart';



	const   _thin = FontWeight.w100;
  const  _extraLight = FontWeight.w200;
  const  _light = FontWeight.w300;
  const _regular = FontWeight.w400;
  const _medium = FontWeight.w500;
  const _semiBold = FontWeight.w600;
  const _bold = FontWeight.w700;
  const _extraBold = FontWeight.w800;
  const _black = FontWeight.w900;

 TextStyle 	get schemeH1 => GoogleFonts.rubik(
			fontSize: 96,
			fontWeight: _light,
			textStyle: TextStyle(color: nearlyBlack, letterSpacing: -1.5));

 TextStyle get schemeH2 => GoogleFonts.rubik(
			fontSize: 60,
			fontWeight: _light,
			textStyle: TextStyle(color: nearlyBlack, letterSpacing: -0.5));

 TextStyle get schemeH3 => GoogleFonts.rubik(
			fontSize: 48,
			fontWeight: _regular,
			textStyle: TextStyle(color: nearlyBlack, letterSpacing: 0));

 TextStyle get schemeH4 => GoogleFonts.rubik(
			fontSize: 34,
			fontWeight: _regular,
			textStyle: TextStyle(color: nearlyBlack, letterSpacing: 1.25));

 TextStyle get schemeH5 => GoogleFonts.rubik(
			fontSize: 24,
			fontWeight: _medium,
			textStyle: TextStyle(color: nearlyBlack, letterSpacing: 0));

 TextStyle get schemeH6 => GoogleFonts.rubik(
			fontSize: 20,
			fontWeight: _medium,
			textStyle: TextStyle(color: nearlyBlack, letterSpacing: 1.25));


 TextStyle get schemeBody1 => GoogleFonts.libreFranklin(
			fontSize: 18,
			fontWeight: _regular,
			textStyle: TextStyle(color: nearlyBlack, letterSpacing: 1.5));

 TextStyle get schemeBody2 => GoogleFonts.libreFranklin(
			fontSize: 15,
			fontWeight: _regular,
			textStyle: TextStyle(color: nearlyBlack, letterSpacing: 1.25));

 TextStyle get schemeTitle1 => GoogleFonts.libreFranklin(
			fontSize: 18,
			fontWeight: _medium,
			textStyle: TextStyle(color: nearlyBlack, letterSpacing: 1.15));

	TextStyle get schemeTitle2 => GoogleFonts.libreFranklin(
			fontSize: 15,
			fontWeight: _medium,
			textStyle: TextStyle(color: nearlyBlack, letterSpacing: 1.1));

 TextStyle get schemeBtnFont => GoogleFonts.libreFranklin(
			fontSize: 15,
			fontWeight: _medium,
			textStyle: TextStyle(color: nearlyBlack, letterSpacing: 1.25));

 TextStyle 	get schemeCaption => GoogleFonts.libreFranklin(
			fontSize: 12,
			fontWeight: _regular,
			textStyle: TextStyle(color: nearlyBlack, letterSpacing: 1.4));

 TextStyle 	get schemeOverLine => GoogleFonts.libreFranklin(
			fontSize: 12,
			fontWeight: _medium,
			textStyle: TextStyle(color: nearlyBlack, letterSpacing: 3));












