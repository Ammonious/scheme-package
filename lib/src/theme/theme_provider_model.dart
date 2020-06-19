import 'package:flutter/material.dart';
import 'package:scheme_package/src/buttons/scheme_button.dart';
import 'package:scheme_package/src/forms/form_constants.dart';
import 'package:scheme_package/src/navigation/model/nav_data.dart';
import 'package:scheme_theme/scheme_theme.dart';
class ThemeProviderModel {
  final String buttonStyle;
  final String color;
  final String fieldStyle;
  final String bottomBarStyle;
  final bool darkMode;
  ThemeProviderModel( {this.darkMode,
    this.buttonStyle,
    this.color,
    this.fieldStyle,
    this.bottomBarStyle,
  });

  ThemeProviderModel copyWith({
    String buttonStyle,
    String fieldStyle,
    String bottomBarStyle,
    String color,
  }) =>
      ThemeProviderModel(
          buttonStyle: buttonStyle ?? this.buttonStyle,
          bottomBarStyle: bottomBarStyle ?? this.bottomBarStyle,
          fieldStyle: fieldStyle ?? this.fieldStyle,
          color: color ?? this.color,
          darkMode: darkMode ?? false
      );

  factory ThemeProviderModel.fromJson(Map<dynamic, dynamic> json) => ThemeProviderModel(
    buttonStyle: json["button_style"] == null ? 'gradient' : json["button_style"],
    bottomBarStyle: json["bottom_bar_style"] == null ? 'neu' : json["bottom_bar_style"],
    fieldStyle: json["field_style"] == null ? 'neu' : json["field_style"],
    color: json["color"] == null ? Colors.blueAccent.shade700.hexString : json["color"],
    darkMode: json['dark_mode'] == null ? false : json['dark_mode'],
  );

  Map<dynamic, dynamic> toJson() => {
    "button_style": buttonStyle == null ? 'gradient' : buttonStyle,
    "field_style": buttonStyle == null ? 'neu' : buttonStyle,
    "bottom_bar_style": buttonStyle == null ? 'neu' : buttonStyle,
    "color": color == null ? Colors.blueAccent.shade700.hexString : color,
  };


// ignore: slash_for_doc_comments
  /********************************
   * ? Initializers
   *********************************/

  SchemeButtonStyle get buttonTheme => _buttonTheme();
  SchemeFieldStyle get fieldTheme => _fieldTheme();

  SchemeBarStyle get bottomBarTheme => _bottomBarTheme();


  SchemeButtonStyle _buttonTheme() {
    if (buttonStyle == 'neu') {
      return SchemeButtonStyle.neu;
    } else if (buttonStyle == 'outline') {
      return SchemeButtonStyle.outline;
    } else if (buttonStyle == 'gradient') {
      return SchemeButtonStyle.gradient;
    } else if (buttonStyle == 'loading') {
      return SchemeButtonStyle.loading;
    }
    return SchemeButtonStyle.gradient;
  }

  SchemeFieldStyle _fieldTheme() {
    if (fieldStyle == 'neu') {
      return SchemeFieldStyle.neu;
    } else if (buttonStyle == 'outline') {
      return SchemeFieldStyle.outline;
    } else if (buttonStyle == 'card') {
      return SchemeFieldStyle.card;
    }
    return SchemeFieldStyle.card;
  }

  SchemeBarStyle _bottomBarTheme() {
    if (bottomBarStyle == 'neu') {
      return SchemeBarStyle.neu;
    } else if (bottomBarStyle == 'normal') {
      return SchemeBarStyle.flat;
    }
    return SchemeBarStyle.neu;
  }


}