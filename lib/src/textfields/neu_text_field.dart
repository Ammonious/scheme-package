import 'package:clay_containers/clay_containers.dart' hide CurveType;
import 'package:clay_containers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scheme_package/src/textfields/textfield_constants.dart' hide CurveType;
import 'package:scheme_package/src/ui/styles.dart';
import 'package:scheme_theme/scheme_theme.dart';

import 'currency_text_editing_controller.dart';
class NeuTextField extends StatefulWidget {
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

  /// [NeuTextField] Properties
  ///
  /// This tells the widget to use a different color for the inside of the container, despite whatever is set in the color field.
  final Color surfaceColor;

  /// This tells the widget to use a different color for the outside emboss/deboss effect, despite whatever is set in the color field.
  final Color parentColor;

  /// This receives a [CurveType] enum. Use this to set the inside surface to look either [convex] or [concave].
  final CurveType curveType;

  /// This is false by default. Set this to true in order to make an embossed container.
  final bool emboss;

  ///  How far should the emboss/deboss effect spread?
  final double spread;

  ///  How strong should the emboss/deboss effect be?
  final int depth;

  /// This receives a number representing a border radius to be applied to all corners of the container.
  final double borderRadius;

  final bool animateOnFocus;

  final TextStyle textStyle;
  final int maxLength;
  final Function onGainedFocus;
  final TextInputAction inputAction;
  final Function(String text) onSubmit;
  final Function(String text) onChange;
  final List<TextInputFormatter> inputFormatters;
  final TextCapitalization textCapitalization;
  final List<BoxShadow> boxShadow;
  final double height;
  final double width;
  NeuTextField({
    Key key,
    @required this.textFocus,
    this.nextFocus,
    this.controller,
    this.boxShadow,
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
    this.onChange,
    this.onGainedFocus,
    this.inputAction = TextInputAction.done,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.height = 72,
    this.showIcon = false,
    this.currencyController,
    this.surfaceColor = Colors.white,
    this.parentColor,
    this.curveType = CurveType.none,
    this.emboss = false,
    this.spread = 6,
    this.depth = 20,
    this.borderRadius = 8,
    this.width,
    this.animateOnFocus = false,
  }) : super(key: key);

  @override
  _NeuTextFieldState createState() => _NeuTextFieldState();
}

class _NeuTextFieldState extends State<NeuTextField> {
  bool hasFocus = false;
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
      textFocus.addListener(() {
        _focusStreamSubject.add(textFocus.hasFocus);
        if (widget.onGainedFocus != null && textFocus.hasFocus) widget.onGainedFocus();
      });
    }

    if (nextFocus != null) {
      nextFocus.addListener(() => _nextFocusStreamSubject.add(nextFocus.hasFocus));
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
        builder: (context, AsyncSnapshot<bool> snapshot) {
          return StreamBuilder(
              stream: _nextFocusStream,
              builder: (context, AsyncSnapshot<bool> snapshot) {
                return ClayContainer(
                  height: widget.height,
                  width: widget.width ?? double.infinity,
                  color: widget.backgroundColor,
                  parentColor: widget.parentColor ?? background,
                  borderRadius: widget.borderRadius,
                  surfaceColor: widget.surfaceColor,
                  depth: widget.depth,
                  spread: widget.spread,
                  emboss: widget.emboss,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                    child: Center(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          primaryColor: widget.brandColor,
                        ),
                        child: TextField(
                          enabled: widget.enabled,
                          focusNode: textFocus,
                          maxLength: widget.maxLength,
                          autofocus: widget.autoFocus,
                          keyboardType: widget.inputType,
                          textInputAction: widget.inputAction,
                          inputFormatters: widget.inputFormatters,
                          textCapitalization: widget.textCapitalization,
                          onChanged: (text) =>
                              widget.onChange != null ? widget.onChange(text) : null,
                          onSubmitted: (text) {
                            if (nextFocus != null && !widget.disableKeyboard) {
                              fieldFocusChange(context, textFocus, nextFocus);
                            } else {
                              dismissKeyboardWithContext(context);
                            }
                            if (widget.onSubmit != null) widget.onSubmit(text);
                          },
                          style: widget.textStyle == null
                              ? schemeTitle1.copyWith(color: widget.textColor)
                              : widget.textStyle.copyWith(color: widget.textColor),
                          maxLines: 1,
                          cursorColor: widget.brandColor,
                          controller: widget.currencyController ?? widget.controller,
                          decoration: widget.showIcon ? inputWithIcon() : inputNoIcon(),
                          obscureText: widget.isPassword,
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }

  inputWithIcon() {
    return InputDecoration(
      icon: Icon(
        widget.iconData,
        color: textFocus.hasFocus ? widget.brandColor : widget.textColor,
      ),
      labelStyle: schemeTitle1.copyWith(
          color: textFocus.hasFocus ? widget.brandColor : widget.textColor.withOpacity(0.55)),
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      labelText: widget.label,
    );
  }

  inputNoIcon() {
    return InputDecoration(
      labelStyle: schemeTitle1.copyWith(
          color: textFocus.hasFocus ? widget.brandColor : widget.textColor.withOpacity(0.55)),
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      labelText: widget.label,
    );
  }
}
