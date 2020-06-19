import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scheme_package/src/forms/form_constants.dart';
import 'package:scheme_theme/scheme_theme.dart' hide SchemeFieldDecoration;
 
import 'card_textfield.dart';
import 'currency_text_editing_controller.dart';
import 'custom_text_field.dart';
import 'neu_text_field.dart';
import 'scheme_field_decoration.dart';

class SchemeTextField extends HookWidget {
  final SchemeFieldStyle fieldStyle;
  final SchemeFieldDecoration decoration;
  final String label;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  final IconData iconData;
  final TextEditingController controller;
  final CurrencyTextFieldController currencyController;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter> inputFormatters;
  final TextStyle textStyle;
  final Color themeColor;
  final Color textColor;
  final Color hintColor;
  final Color backgroundColor;
  final double width;
  final double height;

  /// Whether this should animate on [Focus]
  final bool animateOnFocus;

  final int maxLength;
  final Function(String text) onChange;
  final Function(String text) onSubmit;
  final Function onGainedFocus;
  final bool isPassword;
  final bool enabled;


  SchemeTextField({this.decoration,
                    this.animateOnFocus,
                    this.width,
                    this.height = 72,
                    Key key,
                    this.textStyle,
                    this.maxLength,
                    this.inputFormatters,
                    this.onGainedFocus,
                    this.textCapitalization = TextCapitalization.none,
                    this.fieldStyle = SchemeFieldStyle.outline,
                    this.label = '',
                    this.focusNode,
                    this.isPassword = false,
                    this.enabled = true,
                    this.nextFocus,
                    this.iconData,
                    this.controller,
                    this.currencyController,
                    this.inputType = TextInputType.emailAddress,
                    this.inputAction = TextInputAction.done,
                    this.themeColor = Colors.blue,
                    this.textColor = nearlyBlack,
                    this.hintColor = Colors.grey,
                    this.backgroundColor = Colors.white,
                    this.onChange,
                    this.onSubmit,
                  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(kIsWeb ? 4 : 0),
        child: textField,
      ),
    );
  }

  get textField {
    switch (fieldStyle) {
      case SchemeFieldStyle.card:

        return CardTextField(
          height: decoration != null ? decoration.height : height,
          label: label,
          textFocus: focusNode,
          nextFocus: nextFocus,
          iconData: iconData,
          controller: controller,
          currencyController: currencyController,
          onGainedFocus: () => onGainedFocus,
          showIcon: iconData != null,
          boxShadow: decoration != null ? (decoration.boxShadow ?? flatShadow) : flatShadow,
          enabled: enabled,
          brandColor: themeColor,
          isPassword: isPassword,
          textColor: textColor,
          hintColor: hintColor,
          inputType: inputType,
          maxLength: maxLength,
          inputAction: inputAction,
          textStyle: decoration != null && decoration.textStyle != null ? decoration.textStyle : textStyle,
          textCapitalization: textCapitalization,
          inputFormatters: inputFormatters,
          onChange: (text) => onChange(text),
          onSubmit: (text) => onSubmit(text),
          backgroundColor: decoration != null ? decoration.cardColor : backgroundColor ?? Colors.white,
        );
      case SchemeFieldStyle.outline:
      // TODO: Handle this case.
        return CustomTextField(
          labelText: label,
          controller: controller,
          currencyController: currencyController,
          onGainedFocus: () => onGainedFocus,
          enabled: enabled,
          focusNode: focusNode,
          nextNode: nextFocus,
          maxLength: maxLength,
          obscureText: isPassword,
          onChange: (text) => onChange(text),
          onSubmit: (text) => onSubmit(text),
          textColor: textColor,
          hintColor: hintColor,
          borderColor: hintColor,
          activeBorderColor: themeColor,
          textStyle: textStyle,
          iconData: iconData,
          textCapitalization: textCapitalization,
          showIcon: iconData != null,
          inputFormatters: inputFormatters,
          textInputType: inputType,
          textInputAction: inputAction,
        );
      case SchemeFieldStyle.neu:
        return NeuTextField(
          label: label,
          textFocus: focusNode,
          nextFocus: nextFocus,
          iconData: iconData,
          controller: controller,
          currencyController: currencyController,
          onGainedFocus: () => onGainedFocus,
          showIcon: iconData != null,
          boxShadow: decoration != null ? (decoration.boxShadow ?? flatShadow) : flatShadow,
          enabled: enabled,
          brandColor: themeColor,
          isPassword: isPassword,
          textColor: textColor,
          hintColor: hintColor,
          inputType: inputType,
          maxLength: maxLength,
          inputAction: inputAction,
          textStyle: textStyle,
          textCapitalization: textCapitalization,
          inputFormatters: inputFormatters,
          onChange: (text) => onChange(text),
          onSubmit: (text) => onSubmit(text),
          backgroundColor: backgroundColor,
          parentColor: decoration.parentColor,
          borderRadius: decoration.borderRadius,
          surfaceColor: decoration.cardColor,
          depth: decoration.depth,
          spread: decoration.spread,
          emboss: decoration.emboss,
          width: width,
          height: height,
        );
    }
  }
}