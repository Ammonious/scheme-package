import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/subjects.dart';
import 'package:scheme_package/src/ui/styles.dart';
import 'package:scheme_package/src/utils/constants.dart';
import 'currency_text_editing_controller.dart';
import 'textfield_constants.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final CurrencyTextFieldController currencyController;
  final Function(String text) onSubmit;
  final Function(String text) onChange;
  final String labelText;
  final Color hintColor;
  final Color textColor;
  final Color borderColor;
  final Color activeBorderColor;
  final double borderWidth;
  final double activeBorderWidth;
  final FocusNode focusNode;
  final FocusNode nextNode;
  final TextCapitalization textCapitalization;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;
  final int maxLines;
  final int maxLength;
  final IconData iconData;
  final bool showIcon;
  final bool obscureText;
  final String hintText;
  final TextStyle textStyle;
  const CustomTextField({
    Key key,
    @required this.controller,
    this.onSubmit,
    @required this.labelText,
    this.hintColor = Colors.grey,
    this.textColor = nearlyBlack,
    this.borderColor = Colors.grey,
    this.activeBorderColor = Colors.blue,
    this.borderWidth = 1,
    this.activeBorderWidth = 2,
    this.focusNode,
    this.nextNode,
    this.textCapitalization = TextCapitalization.words,
    this.textInputType = TextInputType.visiblePassword,
    this.onChange,
    this.inputFormatters,
    this.maxLines = 1,
    this.maxLength,
    this.iconData = Boxicons.bxNote,
    this.showIcon = false,
    this.obscureText = false,
    this.hintText,
    this.textInputAction, this.textStyle, this.currencyController,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _focusStreamSubject = PublishSubject<bool>();
  final _nextFocusStreamSubject = PublishSubject<bool>();
  Stream<bool> get _focusStream => _focusStreamSubject.stream;
  Stream<bool> get _nextFocusStream => _nextFocusStreamSubject.stream;

  FocusNode get focusNode => widget.focusNode;
  FocusNode get nextNode => widget.nextNode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (focusNode != null) {
      focusNode.addListener(() => _focusStreamSubject.add(focusNode.hasFocus));
    }

    if (nextNode != null) {
      nextNode.addListener(() => _nextFocusStreamSubject.add(nextNode.hasFocus));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _focusStream,
        builder: (context, snapshot) {
          return StreamBuilder(
              stream: _nextFocusStream,
              builder: (context, snapshot) {
                return TextField(
                  maxLines: widget.maxLines,
                  maxLength: widget.maxLength,
                  maxLengthEnforced: widget.maxLength != null,
                  style: widget.textStyle ?? subtitle1.copyWith(
                    color: widget.textColor,
                  ),
                  textCapitalization: widget.textCapitalization,
                  cursorColor: widget.activeBorderColor,
                  keyboardType: widget.textInputType,
                  controller: widget.currencyController ?? widget.controller,
                  focusNode: focusNode,
                  inputFormatters: widget.inputFormatters,
                  textInputAction: widget.textInputAction,
                  obscureText: widget.obscureText,
                  onChanged: (text) {
                    if (widget.onChange != null) {
                      widget.onChange(text);
                    }
                  },
                  onSubmitted: (text) {
                    if (nextNode != null) {
                      fieldFocusChange(context, focusNode, nextNode);
                    } else {
                      dismissKeyboardWithContext(context);
                    }
                    if (widget.onSubmit != null) {
                      widget.onSubmit(text);
                    }
                  },
                  decoration: widget.showIcon ? inputDecorationWithIcon() : inputDecorationNoIcon(),
                );
              });
        });
  }

  inputDecorationNoIcon() {
    return InputDecoration(
        labelStyle:widget.textStyle ??  subtitle1.copyWith(color: widget.hintColor,),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor, width: widget.borderWidth)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: widget.activeBorderColor, width: widget.activeBorderWidth)),
        border: OutlineInputBorder(borderSide: BorderSide(color: widget.hintColor)),
        labelText: widget.labelText,
        helperText: widget.hintText);
  }

  inputDecorationWithIcon() {
    return InputDecoration(
        icon: Icon(
          widget.iconData,
          color:
              focusNode != null && focusNode.hasFocus ? widget.activeBorderColor : widget.hintColor,
        ),
        labelStyle:widget.textStyle ??  subtitle1.copyWith(color: widget.hintColor,),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor, width: widget.borderWidth)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: widget.activeBorderColor, width: widget.activeBorderWidth)),
        border: OutlineInputBorder(borderSide: BorderSide(color: widget.hintColor)),
        labelText: widget.labelText,
        helperText: widget.hintText);
  }
}
