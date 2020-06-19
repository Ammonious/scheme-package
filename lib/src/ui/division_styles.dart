import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheme_theme/scheme_theme.dart';

final appBarStyle = ({BuildContext context, double opacity, Color color}) => ParentStyle()
  ..height(appbarWithPadding)
  ..boxShadow(color: Colors.black.withOpacity(0.4 * opacity), offset: Offset(1.1, 1.1), blur: 10.0)
  ..background.color(color)
  ..opacity(opacity)
  ..animate(400, Curves.easeInOut);

final appBarTextStyle = TxtStyle()
  ..textColor(nearlyBlack)
  ..fontSize(18)
  ..fontFamily(GoogleFonts.barlow().fontFamily)
  ..letterSpacing(1.15);

final bubbleStyle = (color) => ParentStyle()
  ..height(350)
  ..width(350)
  ..offset(-150, -100)
  ..scale(1.0)
  ..background.color(color)
  ..animate(400, Curves.easeInOut);

final innerBubbleStyle = (color) => bubbleStyle(color).clone()
  ..height(100)
  ..width(100)
  ..offset(100, 100)
  ..scale(1.0)
  ..animate(400, Curves.easeInOut);
