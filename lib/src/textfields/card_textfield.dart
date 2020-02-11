import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scheme_package/src/ui/styles.dart';
import 'package:scheme_package/src/utils/constants.dart';

import 'currency_text_editing_controller.dart';
import 'textfield_constants.dart';

class CardTextField extends StatefulWidget {
  final FocusNode textFocus;
  final FocusNode nextFocus;
  final TextEditingController controller;
  final CurrencyTextFieldController currencyController;
  final Color brandColor;
  final IconData iconData;
  final String label;
  final bool isPassword;
  final bool enabled;
  final bool showIcon;
  final bool disableKeyboard;
  final bool autoFocus;
  final TextInputType inputType;
  final Color textColor;
  final Color hintColor;
  final Color backgroundColor;
  final TextStyle textStyle;
  final int maxLength;
  final Function onGainedFocus;
  final TextInputAction inputAction;
  final Function(String text) onSubmit;
  final List<TextInputFormatter> inputFormatters;
  final TextCapitalization textCapitalization;
  final double height;
  CardTextField({
    Key key,
    @required this.textFocus,
    this.nextFocus,
    this.controller,
    @required this.brandColor,
    @required this.iconData,
    @required this.label,
    this.isPassword = false,
    this.enabled = true,
    this.disableKeyboard = false,
    this.autoFocus = false,
    this.inputType = TextInputType.visiblePassword,
    this.textColor = nearlyBlack,
    this.hintColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.textStyle,
    this.maxLength,
    this.onSubmit,
    this.onGainedFocus,
    this.inputAction = TextInputAction.done,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.height = 72,
    this.showIcon = false, this.currencyController,
  })  : super(key: key);

  @override
  _CardTextFieldState createState() => _CardTextFieldState();
}

class _CardTextFieldState extends State<CardTextField> {
  bool requestedFocus = false;
  final _focusStreamSubject = PublishSubject<bool>();
  final _nextFocusStreamSubject = PublishSubject<bool>();
  Stream<bool> get _focusStream => _focusStreamSubject.stream;
  Stream<bool> get _nextFocusStream => _nextFocusStreamSubject.stream;

  FocusNode get textFocus => widget.textFocus ?? FocusNode();
  FocusNode get nextFocus => widget.nextFocus;

  @override
  void initState() {
    super.initState();
    if (textFocus != null) {
      textFocus.addListener(() => _focusStreamSubject.add(textFocus.hasFocus));
    }

    if (nextFocus != null) {
      nextFocus.addListener(() => _nextFocusStreamSubject.add(nextFocus.hasFocus));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _focusStream,
        builder: (context, snapshot) {
          return StreamBuilder(
              stream: _nextFocusStream,
              builder: (context, snapshot) {
                return Container(
                  height: widget.height,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 25.50,
                            color: Colors.black.withOpacity(0.15),
                            offset: Offset.zero)
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        primaryColor: widget.brandColor,
                      ),
                      child: TextField(
                        enabled: widget.enabled,
                        focusNode: textFocus,
                        autofocus: widget.autoFocus,
                        keyboardType: widget.inputType,
                        textInputAction: widget.inputAction,
                        inputFormatters: widget.inputFormatters,
                        textCapitalization: widget.textCapitalization,
                        onSubmitted: (text) {
                          if (widget.nextFocus != null && !widget.disableKeyboard) {
                            fieldFocusChange(context, textFocus, widget.nextFocus);
                          } else {
                            dismissKeyboardWithContext(context);
                          }
                          if (widget.onSubmit != null) widget.onSubmit(text);
                        },
                        style: widget.textStyle == null
                            ? subtitle1.copyWith(color: widget.textColor)
                            : widget.textStyle.copyWith(color: widget.textColor),
                        maxLines: 1,
                        cursorColor: widget.brandColor,
                        controller: widget.currencyController ?? widget.controller,
                        decoration: widget.showIcon ? inputWithIcon() : inputNoIcon(),
                        obscureText: widget.isPassword,
                      ),
                    ),
                  ),
                );
              });
        });
  }

  inputWithIcon(){
    return InputDecoration(
      icon: Icon(
        widget.iconData,
        color: textFocus.hasFocus ? widget.brandColor : widget.textColor,
      ),
      labelStyle: subtitle1.copyWith(
          color: textFocus.hasFocus
              ? widget.brandColor
              : widget.textColor.withOpacity(0.55)),
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      labelText: widget.label,
    );
  }

  inputNoIcon(){
    return InputDecoration(
      labelStyle: subtitle1.copyWith(
          color: textFocus.hasFocus
              ? widget.brandColor
              : widget.textColor.withOpacity(0.55)),
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      labelText: widget.label,
    );
  }
}
